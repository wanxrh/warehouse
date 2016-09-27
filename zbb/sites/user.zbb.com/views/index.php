<?php $this->load->view('header');?>
    

<div class="g-wrap clearfix">
    <div class="g-mn">
        <div class="g-mnc">
            <!--  正文  -->
            <div class="m-uInfo">  
               
                <div class="pic">
                    <img src="<?php echo img_url($myinfo['portrait']);?>" alt="" id="imgShow" onerror="this.onerror=null,this.src='<?php echo $this->config->item('domain_static'); ?>user/img/default.gif' ">
                </div>
                    <div class="box">
                    <form method="post" id="J_form" action="/myinfo/portrait" enctype="multipart/form-data">
                        <input type="file" class="file" onchange="javascript:setImagePreview();" ectype="change_store_logo" hidefocus="true" maxlength="0" size="1" id="up_img" name="store_logo" /><label class="setcode" >更改图标</label><label class="submitd">上传</label>
                        </form>
                    </div>
                
                <div class="lst">
                    <dl>
                        <dt>商家会员名:<?php echo $myinfo['user_name'];?></dt>
                        <dd><span>手机：</span><?php echo $mobile;?></dd>
                        <dd><span>认证：</span>已认证√</dd>
                        <dd>
                            <span>账户余额：</span>
                            <em class="price"></em>
                            <em class="hide">***</em>
                            <em id="J_showMoney" data-shw="0"  class="rst">[查看]</em>

                        </dd>  
                    </dl>
                </div>
            </div>
            <div class="m-msg">
                <ul>
                    <li><a href="/orders/lists?status=20">待发货<span><?php echo $un_ship;?></span></a></li>
                    <li><a href="/service/lists">待处理退款<span><?php echo $un_refund;?></span></a></li>
                    <li><a href="/message/lists">待查看消息<span><?php echo $un_read;?></span></a></li>
                    <li><a href="/orders/lists?status=40">已卖出宝贝<span><?php echo $finished;?></span></a></li>
                </ul>
            </div>

            <!-- <div class="m-topics">
                 <div class="tt">特色专场</div>
                 <div class="tip">
                     上专场流程: ①在“全部宝贝管理”中选择宝贝 → ②点击“报名专场”，选择专场 → ③众宝贝审核通过 → ④系统自动按专场时间更新宝贝
                 </div>
                 <div class="mn">
                     <ul>
                         <li></li>
                         <li></li>
                         <li></li>
                         <li></li>
                     </ul>
                 </div>
             </div>-->

                     <!--  正文 END -->
        </div>
    </div>
    <div class="g-sd">
        <?php $this->load->view('menu');?>
    </div>
</div>
<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>user/js/index.js" charset="utf-8"></script>
<?php $this->load->view('footer');?>