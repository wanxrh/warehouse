<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

/**
 * mongodb 操作类
 */
class MongoOperate
{

    /**
     * 保存CI超级对象
     * @var
     */
    protected $CI;

    /**
     * 保存mongo连接实例
     * @var null
     */
    private static $_mongoConnInstance = null;

    /**
     * 保存mongo数据库对象实例
     * @var null
     */
    private static $_mongoDBInstance = null;

    /**
     * @var  用户名
     */
    protected $_username = "";

    /**
     * @var  密码
     */
    protected $_password = "";

    /**
     * @var  mongo服务器地址（包括端口） example：192.168.0.1:27017
     */
    protected $_host = "";

    /**
     * 数据库名
     * @var
     */
    protected $_database = "";


    /**
     * 要操作的文档（表）
     * @var array
     */
    protected $_documents = array();


    public function __construct()
    {
        try {
            $this->CI = &get_instance();
            if (!extension_loaded('mongo')) {
                $this->CI->error = array('errcode' => 'NOT_FOUND_EXTENSION_MONGO', 'errtxt' => 'mongo扩展没有安装.');
                log_message('error', 'mongo扩展没有安装.');
                exit("mongo扩展没有安装");
            }
            $this->CI->config->load('mongo');
            $this->_host = $this->CI->config->item('mongo_host') or show_error('缺少配置项：mongo_host');
            $this->_username = $this->CI->config->item('mongo_username') or show_error('缺少配置项：mongo_username');
            $this->_password = $this->CI->config->item('mongo_password') or show_error('缺少配置项：mongo_password');
            $this->_database = $this->CI->config->item('mongo_database') or show_error('缺少配置项：mongo_database');
            $this->_documents = $this->CI->config->item('mongo_documents') or show_error('缺少配置项：mongo_documents');
            self::$_mongoConnInstance = new MongoClient("mongodb://" . $this->_username . ":" . $this->_password . "@" . $this->_host, array('db' => $this->_database, 'connectTimeoutMS' => 10000));
            if (self::$_mongoConnInstance) {
                self::$_mongoDBInstance = self::$_mongoConnInstance->selectDB($this->_database);
            } else {
                $this->error = array('errcode' => 'CONNECT_ERROR', 'errtxt' => 'mongo客户端连接失败');
            }
        } catch (MongoConnectionException $e) {
            $trace = $e->getTrace();
            log_message('error', $e->getMessage() . '  File:' . $trace[0]['file'] . '  Line:' . $trace[0]['line']);
            show_error($e->getMessage());
        }

    }


    /**
     * 插入数据操作
     * @param $documentName 表明
     * @param $data 写死只能传数组
     * @param $option 选项
     *         wTimeoutMS 写超时 默认5秒
     *         .....
     */
    public function insert($documentName, $data, $option = array('wTimeoutMS' => 5000))
    {
        $this->preWriteToCollectionCheck($documentName, $data);
        $collection = $this->getCollection($documentName);
        try {
            $res = $collection->insert($data, $option);
        } catch (MongoException $e) {
            $trace = $e->getTrace();
            log_message('error', $e->getMessage() . '  File:' . $trace[0]['file'] . '  Line:' . $trace[0]['line']);
            show_error($e->getMessage());
        }
        return $res;
    }

    /**
     * @param $documentName  文档名 string
     * @param $condition   更新条件 array
     * @param $data        要更新的列 array
     * @param array $option 选项
     *          upset :  如果设置为true的话 没有找到跟$condition条件匹配的项,则将$data执行insert操作 默认为false;
     *          multiple : 如果设置为true 所有匹配$condition条件的文档记录将被更新，false：将只更新匹配到的第一条 默认true
     *          wTimeoutMS : 写超时默认设置为5秒
     */
    public function update($documentName, $condition, $data, $option = array('upsert' => false, 'multiple' => true, 'wTimeoutMS' => 5000))
    {
        $this->preWriteToCollectionCheck($documentName, $data);  //检查新数据
        $this->preWriteToCollectionCheck($documentName, $condition);  //检查条件数组
        $collection = $this->getCollection($documentName);
        try {
            $res = $collection->update($condition, array('$set' => $data), $option);
        } catch (MongoException $e) {
            $trace = $e->getTrace();
            log_message('error', $e->getMessage() . '  File:' . $trace[0]['file'] . '  Line:' . $trace[0]['line']);
            show_error($e->getMessage());
        }

        return $res;
    }

    /**
     * @param $documentName   文档名
     * @param $condition      可选参数  查询条件
     * @param $filed          可选参数  查询字段
     * @param $skip           可选参数  从游标中跳过多少条取记录 默认0
     * @param $limit          可选参数  从游标中取多少条记录  默认50
     * @param $sort           可选参数  对结果集中的文档进行排序 example： array('id'=>1) 以id升序排列  -1 为倒序
     * @param $isCount  是否是对查询结果进行统计，默认false，如果设置为true则返回查询总数
     * @param $count_i_limit  查询统计是否忽略limit 默认false
     * @return array | int
     */
    public function find($documentName, $condition = array(), $filed = array(), $skip = 0, $limit = 50, $sort = array(), $isCount = false, $count_i_limit = false)
    {
        $skip = intval($skip);
        $limit = intval($limit);
        $collection = $this->getCollection($documentName);
        try {
            $cursorObj = $collection->find($condition, $filed)->skip($skip)->limit($limit)->sort($sort);
            $result = array();
            try {
                if (!$isCount) {
                    while ($cursorObj->hasNext()) {
                        array_push($result, $cursorObj->getNext());
                    }
                } else {
                    $result = $cursorObj->count($count_i_limit);  //如果MongoCursor::count()方法可以有一个可选参数如果传人true则会根据limit方法返回的结果，默认是false 忽略limit
                }
            } catch (MongoCursorException $e) {
                $trace = $e->getTrace();
                log_message('error', $e->getMessage() . '  File:' . $trace[0]['file'] . '  Line:' . $trace[0]['line']);
                show_error($e->getMessage());
            }
        } catch (MongoException $e) {
            $trace = $e->getTrace();
            log_message('error', $e->getMessage() . '  File:' . $trace[0]['file'] . '  Line:' . $trace[0]['line']);
            show_error($e->getMessage());
        }

        return $result;

    }

    /**
     * 从结果集中只取一个文档
     * @param $documentName  文档集合名
     * @param array $condition 查询条件
     * @param array $filed 查询字段
     * @param array $option 选项  maxTimeMS：超过最大执行时间抛出异常
     * @return array|null  返回值
     */
    public function findOne($documentName, $condition = array(), $filed = array(), $option = array('maxTimeMS' => 10000))
    {
        $collection = $this->getCollection($documentName);
        try {
            $res = $collection->findOne($condition, $filed);

        } catch (MongoException $e) {
            $trace = $e->getTrace();
            log_message('error', $e->getMessage() . '  File:' . $trace[0]['file'] . '  Line:' . $trace[0]['line']);
            show_error($e->getMessage());
        }

        return $res;
    }

    /**
     * 从集合中删除文档
     * @param $documentName  集合名
     * @param array $condition 删除文档的条件
     * @param array $option 选项
     *               justOne  最多只匹配一条记录 这里防止误删  默认设置为true
     *               wTimeoutMS  写超时 默认10秒超时抛出异常
     *
     */
    public function remove($documentName, $condition = array(), $option = array('justOne' => true, 'wTimeoutMS' => 10000))
    {
        $collection = $this->getCollection($documentName);
        try {
            $res = $collection->remove($condition, $option);
        } catch (MongoException $e) {
            $trace = $e->getTrace();
            log_message('error', $e->getMessage() . '  File:' . $trace[0]['file'] . '  Line:' . $trace[0]['line']);
            show_error($e->getMessage());
        }

        return $res;
    }


    /**
     * 获取配置的document结构
     * @param $index  mongo_documents配置项索引 从0开始
     * @param $structure  要获取的结构名 name：获取document名，field：获取列名，all：名和列都获取
     */
    public function getDocument($index, $structure = 'name')
    {
        $index = intval($index);
        switch (strtolower($structure)) {
            case 'name':
                $names = array_keys($this->_documents);
                return $names[$index];
                break;
            case 'field':
                $fields = array_values($this->_documents);
                return $fields[$index];
                break;
            case 'all':
                $documents = $this->_documents;
                return $documents[$index];
                break;
            default :
                show_error("未知DOCUMENT结构");
        }
    }


    /**
     * 获取集合对象
     * @param $documentName  文档名（表名）
     * @return MongoCollection
     */
    protected function getCollection($documentName)
    {
        try {
            $collection = self::$_mongoDBInstance->selectCollection($documentName);
        } catch (MongoException $e) {
            $trace = $e->getTrace();
            log_message('error', $e->getMessage() . '  File:' . $trace[0]['file'] . '  Line:' . $trace[0]['line']);
            show_error($e->getMessage());
        }
        return $collection;
    }


    /**
     * 写表之前的检测
     * @param $documentName  表名
     * @param $data   操作数据
     * @return void
     */
    protected function preWriteToCollectionCheck($documentName, $data)
    {

        if ('' == trim($documentName)) {
            show_error("文档名不能为空字符");
        }

        if (preg_match('/.?[$|^|&|*|#|@|\?|\(|\)|\.|%].?/', $documentName)) {
            show_error("文档名不能含有特殊符号");
        }

        if (!in_array(trim($documentName), array_keys($this->_documents))) {
            show_error('要操作的文档名未配置');
        }

        if (!is_array($data) || empty($data)) {
            show_error("操作参数非数组或者数组为空");
        }
        foreach ($data as $k => $v) {
            if (!in_array($k, $this->_documents[$documentName])) {
                show_error("mongodb文档集合" . $documentName . "字段名" . $k . "未配置");
            }

            if (preg_match('/.?[$|^|&|*|#|@|\?|\(|\)|\.|%].?/', $k)) {
                show_error("mongodb文档集合" . $documentName . "字段名" . $k . "包含未允许特殊符号");
            }


            if (preg_match('/.?[$|^|&|*|#|@|\?|\(|\)|%].?/', $v)) {
                show_error("mongodb文档集合" . $documentName . "字段值" . $v . "包含未允许特殊符号");
            }
        }
    }


}