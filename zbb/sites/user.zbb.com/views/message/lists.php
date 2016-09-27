<?php $this->load->view('header');?>

<div class="g-wrap clearfix">
    <div class="g-mn">
        <div class="g-mnc">
            <!--  正文  -->
            <div class="m-tt">
                <p class="f-fr"><label> <input type="checkbox" id="J_all"> 选择 </label>　<a href="javascript:void(0)" id="J_all_del">删除</a>　　</p>
                <span>消息列表<em></em></span>
            </div>
            <div class="m-msg-list">
                <ul>
                <?php foreach ($message as $k => $v): ?>
                    <li class="itme <?php $read = $v['is_sys'] ==0 ? 'read':''; echo $read; ?>">
                        <div class="tt">
                            <span class="f-fr">
                                <label> <input type="checkbox" class="J-checkbox" data-id="<?php echo $v['msg_id'] ?>"> 选择 </label>　<span class="J_del" data-id="<?php echo $v['msg_id'] ?>">删除</span>
                            </span>
                            <div class="info J_info" data-id="<?php echo $v['msg_id'] ?>"><span class="state"></span>
                                <?php echo $v['add_time'] ?> <span><?php echo $v['title'] ?> </span>
                            </div>
                            
                        </div>
                        <div class="cont">
                            消息内容XXX
                        </div>
                    </li>
				<?php endforeach;?>
                </ul>
            </div>
            <?php echo $page; ?>
        </div>
    </div>
    <div class="g-sd">
        <?php $this->load->view('menu');?>
    </div>
</div>

<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>user/js/message.js" charset="utf-8"></script>

<?php $this->load->view('footer');?>