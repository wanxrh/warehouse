<?php $this->load->view('header');?>
<link href="<?php echo $this->config->item('domain_static'); ?>common/js/webuploader/webuploader.css" rel="stylesheet"/>

<style type="text/css">

    #uploader .placeholder{
        display: none;
    }
    #uploader .filelist,#uploader, #uploader .queueList{
        width:auto;
    }
    #uploader .webuploader-pick{
        margin: 0 0 5px 0;
        width: 86px;
        background-color:#f6f6f6;
        border: 1px solid #ccc;
        color: #666
    }
    .webuploader-container{
        width: 160px;
        position: relative;
    }
    #uploader .statusBar{
        width: 136px;
    }
    .webuploader-container{
        float: left;
    }
    .hint-text{
        float: left;
        margin-top: 10px;
    }
    #J_act_2{
        display: none;
    }
</style>
<div class="g-wrap clearfix">
    <div class="m-step">
        <?php if($refund_info['status']==AFTERMARKET_SUCCESS){?>
        <span class="dot">1
            <h3>买家  申请退款</h3>
        </span>
        <span class="dot r-act-2">2
            <h3>处理退款申请</h3>
        </span>
        <span class="dot r-act-3">3
            <h3>　退款完成　　</h3>
        </span>
            <div class="line">
                <div class="r-move-3"></div>
            </div>
        <?php }?>
        <?php if($refund_info['status']==AFTERMARKET_CLOSE){?>
            <span class="dot-s">1
            <h3>买家  申请退款</h3>
        </span>
            <span class="dot-s r-act-2">2
            <h3>处理退款申请</h3>
        </span>
            <span class="dot-s r-act-3">3
            <h3>　退款完成　　</h3>
        </span>
            <div class="line">
                <div ></div>
            </div>
        <?php }?>
        <?php
        $temp_arr=array(
            AFTERMARKET_HANDLE,
            AFTERMARKET_AGREE,
            AFTERMARKET_REFUSE,
            AFTERMARKET_GOODS_RETURNING,
            AFTERMARKET_REFUSE_RETURN,
            AFTERMARKET_INTERVENE,
            );
        ?>
        <?php if(in_array($refund_info['status'], $temp_arr)){?>
            <span class="dot">1
            <h3>买家  申请退款</h3>
        </span>
            <span class="dot r-act-2">2
            <h3>处理退款申请</h3>
        </span>
            <span class="dot r-act-3">3
            <h3>　退款完成　　</h3>
        </span>
            <div class="line">
                <div class="r-move-2"></div>
            </div>
        <?php }?>

    </div>
</div>
<div class="g-wrap clearfix m-refund">
    <div class="g-mn">
        <div class="g-mnc">
            <div id="J_act_1" class="act">
                <div class="tt">
                    <input id="time" type="hidden" value="<?php echo time();?>">
                    <?php if(($refund_info['status']==AFTERMARKET_CLOSE)||($refund_info['status']==AFTERMARKET_SUCCESS)){?>
                    <div class="j-timer time" data-time="">
                        <?php }else{?>
                        <div class="j-timer time" data-time="<?php echo $refund_info['countdown'];?>">
                        <?php }?>
                        -
                    </div>


                    <?php if($refund_info['status']==AFTERMARKET_HANDLE){?>
                    <!-- 未处理 --><span>请处理退款</span>
                    <?php } ?>
                    <?php if($refund_info['status']==AFTERMARKET_SUCCESS){?>
                        <!-- 未处理 --><span>退款成功</span>
                    <?php } ?>
                    <?php if($refund_info['status']==AFTERMARKET_REFUSE){?>
                    <!-- 已处理 --><span>您已拒绝退款，请等待买家回应</span>
                    <?php } ?>
                </div>
                <!-- 未处理 -->
                <?php if($refund_info['status']==AFTERMARKET_HANDLE){?>
                    <ul class="txt-tip">
                        <li>如果未发货，请点击同意退款给买家。</li>
                        <li>如果实际已发货，请主动与买家联系。</li>
                        <li>如果您逾期未响应，视作同意买家申请，系统将自动退款给买家。</li>
                        <li>如果您想拒绝退款申请，可以点击发货/拒绝退款申请，系统将关闭退款申请。</li>
                    </ul>
                    <div class="f-tac">
                        <button class="btn" id="J_agree" data-rid="<?php echo $refund_info['rec_id'];?>">同意退款申请</button>
                    </div>
                    <div class="m-rsd">
                        您还可以：
                        <?php if($refund_info['order_status']==ORDER_PAID){?>
                        <a class="refused" href="/express/send?order_id=<?php echo $refund_info['order_id'];?>">发货</a>
                        <?php } ?>
                        <?php if($refund_info['order_status']==ORDER_SHIPPED){?>
                        <span class="refused" id="J_refuse">拒绝退款申请</span>
                        <?php } ?>
                    </div>
                <?php } ?>
                <!-- 未处理 end-->

                <!-- 已处理 -->
                <?php if($refund_info['status']==AFTERMARKET_AGREE){?>
                    <ul class="txt-tip">
                        <li>如果买家逾期未响应，系统将自动关闭退款申请。</li>
                    </ul>
                <?php } ?>
                <?php if($refund_info['status']==AFTERMARKET_SUCCESS){?>
                    <ul class="txt-tip">
                        <li>退款金额:<?php echo $refund_info['money'];?>元。</li>
                    </ul>
                <?php } ?>
                <!-- 已处理 end-->
                <?php if($refund_info['status']==AFTERMARKET_CLOSE){?>
                    <ul class="txt-tip">
                        <li>申请已关闭。</li>
                    </ul>
                <?php } ?>

            </div>
            
            <div id="J_act_2" class="act">
                <div class="tip"><span>注：</span>您拒绝申请后，买家可能会要求客服介入处理，如果客服核实是您的责任，将影响您的店铺。</div>
                <div class="form-box" >
                    <dl class="clearfix">
                        <dt>拒绝原因：</dt>
                        <dd>
                            <select name="refuse_reason" id="J-type">
                                <option value="0">请选择拒绝理由</option>
                                <?php foreach ($reason_info as $v){?>
                                    <option value="<?php echo $v['id'];?>"><?php echo $v['reason'];?></option>
                                <?php } ?>
                            </select>
                        </dd>
                    </dl>
                    <dl class="clearfix">
                        <dt>拒绝说明：</dt>
                        <dd>
                            <textarea rows="6" cols="60" name="supplement" id="remark"  placeholder="您可以告知买家具体原因。"></textarea>
                        </dd>
                    </dl>
                    <dl class="clearfix">
                        <dt>上传凭证：</dt>
                        <dd class="clearfix">
                            <div id="uploader">
                                <div class="queueList">
                                    <div id="dndArea" class="placeholder" style="display:none">
                                        <img id="big_goods_image" src="<?php echo $this->config->item('domain_static'); ?>user/img/default.gif"  alt="" />
                                        <!-- <div id="filePicker"></div>-->
                                    </div>
                                    <div class="clearfix">
                                        <div id="filePicker"></div>
                                        <p class="hint-text">最多可上传5张，每张不超过400K，支持GIF,JPEG,JPG,PNG,BMP格式</p>
                                    </div>
                                    
                                    <ul class="filelist"></ul>
                                </div>
                                <div class="statusBar">
                                    <div class="uploadBtn">开始上传</div>
                                </div>
                            </div>
                            <input type="hidden" name="uploadimg" id="uploadimg" value="">
                        </dd>
                    </dl>
                    <div class="statusBar">
                        <div class="uploadBtn">开始上传</div>
                    </div>
                    <div class="f-tal">
                        <button class="btn" id="J_refused" data-rid="<?php echo $refund_info['rec_id'];?>">确认拒绝</button>　
                        <span class="refused" id="J_cancel">撤消并返回</span>
                    </div>
                </div>
            </div>

            <?php $this->load->view('refund/diary');?>
            
        </div>
    </div>
    <div class="g-sd">
        <?php $this->load->view('refund/side');?>
    </div>
</div>

<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>user/js/refundMoney.js" charset="utf-8"></script>

<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>common/js/jquery-1.11.0.min.js" charset="utf-8"></script>
<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>common/js/webuploader/webuploader.js"></script>
<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>user/js/upload_back.js"></script>
<?php $this->load->view('footer');?>