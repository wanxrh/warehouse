<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

$config['mongo_host'] = '192.168.0.242:27017'; // 服务器地址:端口
$config['mongo_username'] = 'logDBAdmin';         // 用户名
$config['mongo_password'] = 'zbb123';           //  密码
$config['mongo_database'] = 'log';             //  数据库名

/**要操作的文档名(相当于mysql的表名的概念)
 * 本项配置的目的是在执行文档操作的时候验证文档是否为可操作的
 * *****本项配置测试人员不能更改*******
 */
$config['mongo_documents'] = array(
    'refund_log' => array(
        'apply_refund_id',//售后申请记录ID
        'target_id',//申请退款/退货ID
        'node_id',//节点ID
        'node',//节点
        'node_time',//节点时间
        'order_sn',//订单编号
        'refund_money',//退款金额
        'refund_reason',//退款原因
        'claim',//要求
        'supplement',//补充说明
        'proof',//凭证
        'refuse_reason',//拒绝原因
        'addr',//地址
        'express',//快递
        'express_number',//快递编号
        'close_reason',//原因
        'timer'//定时器产生的日志
    )
);