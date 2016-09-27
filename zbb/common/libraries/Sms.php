<?php

/**
 * 短信发送接口类
 * @author weigang
 * @version 20150518
 *
 */

class Sms {
    
    private $base_url = 'http://211.147.244.114:9801/CASServer/SmsAPI/SendMessage.jsp';
    private $user_id  = 87820;
    private $password = 'l4ObvU9texO1m8n2';
    
    public function __construct()
    {
        # demo
        /* $this->load->library('sms');
        $ret = $this->sms->send('1XXXXXXXX13', '【中国移动】温馨提示XXXXXX');
        $ret = (array)json_decode($ret, TRUE);
        var_dump($ret);
        exit(); */
    }
    
    /**
     * 设置接口参数
     * @param string $base_url
     * @param string $user_id
     * @param string $password
     * @return boolean
     */
    public function set_api_param($base_url='', $user_id='', $password='')
    {
        if ($base_url) {
            $this->base_url = $base_url;
        }
        
        if ($user_id) {
            $this->user_id = $user_id;
        }
        
        if ($password) {
            $this->password = $password;
        }
        
        return true;
    }
    
    /**
     * 短信发送
     * @param $mobile   接收手机号码
     * @param $content  短信内容
     */
    public function send($mobile, $content)
    {
        if (empty($mobile)) {
            return json_encode(array('status' => 'n', 'code' => 11, 'info' => '号码参数缺失'));
        }
        
        if (empty($content)) {
            return json_encode(array('status' => 'n', 'code' => 12, 'info' => '短信内容参数缺失'));
        }

        if(!preg_match("#1[\d]{10}#", $mobile)) {
            return json_encode(array('status' => 'n', 'code' => 10, 'info' => '号码格式错误'));
        }
        
        $url = '';
        $url .= $this->base_url;
        $url .= '?userid=' . $this->user_id;
        $url .= '&password=' . urlencode($this->password);
        $url .= '&destnumbers=' . $mobile;
        $url .= '&msg=' . urlencode($content);
        
        // get xml string result from url
        $xmlstring = '';
        if (function_exists('file_get_contents')) {
            
            $xmlstring = file_get_contents($url);
        } else if (function_exists('fopen')) {
            
            $fopenXML = fopen($url, 'r');
        
            if ($fopenXML) {
                while ( ! feof($fopenXML)) {
                    $xmlstring .= fgets($fopenXML, 4096);
                }
        
                fclose($fopenXML);
            }
        }
        
        $xmlstring = trim($xmlstring);
        
        if(empty($xmlstring)) {
            return json_encode(array('status' => 'n', 'code' => 13, 'info' => '参数错误'));
        }
        
        // parse xml string
        $xmlparser = xml_parser_create();
        xml_parse_into_struct($xmlparser, $xmlstring, $output);
        if (xml_parser_free($xmlparser)) {
            return json_encode(array('status' => 'y', 'code' => 1, 'info' => '成功发送短信'));
        } else {
            return json_encode(array('status' => 'n', 'code' => 0, 'info' => '发送短信失败'));
        }
    }
    
}








