<?php

/**
 * 用户中心控制器
 */
class Store extends CI_Controller
{

    public function __construct()
    {
        parent::__construct();
        header("Content-type: text/html; charset=utf-8");
        $user_id = get_user()['id'];
        if (!$user_id) {
            header('Location: ' . $this->config->item('domain_www'));
            exit;
        }
        $this->load->model('store_model');
    }

    public function manage()
    {
        $user_id = get_user();
        $ret = $this->store_model->store_info($user_id['id']);

        $data['province_name'] = $this->store_model->get_region_name($ret['province_id']);//省名
        $data['city_name'] = $this->store_model->get_region_name($ret['city_id']);//市名
        $data['country_name'] = $this->store_model->get_region_name($ret['country_id']);//区名

        $data['province'] = $this->store_model->get_region(0);//省id
        $data['city'] = $this->store_model->get_region($ret['province_id']);//市id
        $data['country'] = $this->store_model->get_region($ret['city_id']);//省id
        $data['store_info'] = $ret;

        $this->load->view('store/manage', $data);
    }

    public function get_manage(){

        if(IS_POST) {
            $post = $this->input->post(NULL, TRUE);
            //判断是否上传图片
            if(!empty($_FILES['store_logo']['name'])){
                $file = $this->_upload_image('store_logo');
            }else{
                $file ='';
            }
            $data = array(
                'store_name' => $post['store_name'],
                'province_id' => $post['province_id'],
                'city_id' => $post['city_id'],
                'country_id' => $post['country_id'],
                'address' => $post['address'],
                'tel' => $post['tel'],
                'im_qq' => $post['im_qq'],
                'im_ww' => $post['im_ww'],
                'store_logo' => $file,
                'region_name'=>$post['region_name'],
            );
            $this->store_model->store_save($post['store_id'], $data);
            get_redirect('修改成功', '/store/manage');
        }
    }

    public function apply()
    {
        $data['cate'] = $this->store_model->get_cate();
        if (IS_POST) {
            $arr = $this->input->post(null, true);
            $card_img_1 = $this->_upload_image('card_img_1');
            $card_img_2 = $this->_upload_image('card_img_2');
            //判断是否已经有记录
            $ret=$this->store_model->apply_info(get_user()['id']);
            if($ret){
                //更新操作
                $company_arr = array(
                    'uname' => filter_sql($arr['uname']),
                    'email' => filter_sql($arr['email']),
                    'mobile' => filter_sql($arr['mobile']),
                    'corporation' => filter_sql($arr['corporation']),
                    'id_card' => filter_sql($arr['id_card']),
                    'card_imgs' => $card_img_1 . ',' . $card_img_2,
                    'step' => 1
                );
                $this->store_model->apply_save(get_user()['id'],$company_arr);
            }else{
                //插入操作
                $company_arr = array(
                    'uname' => filter_sql($arr['uname']),
                    'user_id' => get_user()['id'],
                    'email' => filter_sql($arr['email']),
                    'mobile' => filter_sql($arr['mobile']),
                    'corporation' => filter_sql($arr['corporation']),
                    'id_card' => filter_sql($arr['id_card']),
                    'card_imgs' => $card_img_1 . ',' . $card_img_2,
                    'step' => 1
                );
                $this->store_model->company_save($company_arr);
            }
        }
        $this->load->view('store/apply', $data);
    }

    public function get_cate()
    {
        //ajax调用
        $parent_id = intval($this->input->post('parent_id'));
        $ret = $this->store_model->get_cate($parent_id);
        if ($ret) {
            ajax_success($ret);
        } else {
            ajax_error('无分类信息');
        }
    }

    public function company()
    {
        $this->load->view('store/company');
    }

    public function protocol()
    {
        //获取当前步骤
        $user_id = get_user()['id'];
        $ret = $this->store_model->apply_info($user_id);

        if ($ret) {

            if($ret['status']==2){
                header('Location: ' . $this->config->item('domain_user') . 'store/outcome');
                exit;
            }

            switch ($ret['step']) {
                case 1:
                    header('Location: ' . $this->config->item('domain_user') . 'store/apply');
                    exit;
                    break;
                case 2:
                    header('Location: ' . $this->config->item('domain_user') . 'store/under_review');
                    exit;
                    break;
            }
        }

        $this->load->view('store/protocol');
    }

    public function under_review()
    {
        $user_id = get_user()['id'];
        $ret=$this->store_model->store_info($user_id);
        if($ret){
            header('Location: ' . $this->config->item('domain_user'));
        }
        if (IS_POST) {
            $arr = $this->input->post(null, true);

            if ($arr['store_type'] == 5) {
                //C店
                $apply_arr = array(
                    'store_name' => filter_sql($arr['store_name']),
                    'cate_1' => intval($arr['cate_1']),
                    'cate_2' => intval($arr['cate_2']),
                    'dateline'=>time(),
                    'store_type' => intval($arr['store_type']),
                    'status'=>0,
                    'step' => 2
                );
                $this->store_model->apply_save($user_id, $apply_arr);
            } else {
                //其他店
                if ($arr['typeA'] == 2) {
                    $company_img = $this->_upload_image('image_4');
                } else {
                    $img1 = $this->_upload_image('image_1');
                    $img2 = $this->_upload_image('image_2');
                    $img3 = $this->_upload_image('image_3');
                    $company_img = $img1 . ',' . $img2 . ',' . $img3;
                }
                if($arr['start_end']=1){
                    $start_end=date('Y-m-d',time()).'至9999-12-31';
                }else{
                    $start_end=$arr['start_time'].'至'.$arr['end_time'];
                }

                $apply_arr = array(
                    'store_name' => filter_sql($arr['store_name']),
                    'cate_1' => intval($arr['cate_1']),
                    'cate_2' => intval($arr['cate_2']),
                    'store_type' => intval($arr['store_type']),
                    'start_end'=>$start_end,
                    'company_name' => filter_sql($arr['company_name']),
                    'license' => filter_sql($arr['license']),
                    'company_img' => $company_img,
                    'dateline'=>time(),
                    'status'=>0,
                    'step' => 2,
                    'bank_sn' => empty($arr['bank_sn']) ? '' : filter_sql($arr['bank_sn'])
                );
                $this->store_model->apply_save($user_id, $apply_arr);
            }


            if ($arr['store_type'] == 5) {
                header('Location: ' . $this->config->item('domain_user') . 'store/check_store');
                exit;
            }
        }
        $this->load->view('store/under_review');
    }


    public function check_store()
    {
        $check_url = filter_sql($this->input->post('check_url'));
        if(!empty($check_url)) {
            $user_id = get_user()['id'];
            $ret = $this->store_model->save_url($user_id, $check_url);
            if ($ret) {
                header('Location: ' . $this->config->item('domain_user') . 'store/under_review');
                exit;
            }
        }
        $this->load->view('store/check_store');
    }

    public function outcome()
    {
        //读取失败原因
        $data['info']=$this->store_model->apply_info(get_user()['id']);
        $this->load->view('store/outcome',$data);
    }

    /**
     * 图片上传
     */
    protected function _upload_image($img)
    {
        $this->load->library('uploader');
        $this->uploader->allowed_size(6000000); // 400KB
        $file = $_FILES[$img];

        if ($file['error'] == UPLOAD_ERR_OK) {
            if (empty($file)) {
                return false;
            }
            $this->uploader->addFile($file);
            if (!$this->uploader->file_info()) {
                show_error($this->uploader->get_error());
            }
            $info = $this->uploader->file_info();
            $type = $info['extension'];
            $Y = date("Y", time());
            $m = date("m", time());
            $d = date("d", time());
            $dir_name = 'store/' . $Y . '/' . $m . '/' . $d;
            $filename = time() . rand(1000, 9999);
            $this->uploader->save($dir_name, $filename);
        }
        return 'store/' . $Y . '/' . $m . '/' . $d . '/' . $filename . '.' . $type;
    }


}