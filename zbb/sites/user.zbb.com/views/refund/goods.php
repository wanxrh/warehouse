<?php $this->load->view('header');?>
<link href="<?php echo $this->config->item('domain_static'); ?>common/js/webuploader/webuploader.css" rel="stylesheet"/>
<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>common/js/jquery-1.11.0.min.js" charset="utf-8"></script>
<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>common/js/webuploader/webuploader.js"></script>
<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>user/js/upload_back.js"></script>
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
        <span class="dot act-2">2
            <h3>处理退货申请</h3>
        </span>
        <span class="dot act-3">3
            <h3>　买家退货　　</h3>
        </span>
         <span class="dot act-4">3
            <h3>　退货完成　　</h3>
        </span>
        <div class="line">
            <div class="move-4"></div>
        </div>
         <?php }?>
         <?php if($refund_info['status']==AFTERMARKET_CLOSE){?>
             <span class="dot-s">1
            <h3>买家  申请退款</h3>
        </span>
             <span class="dot-s act-2">2
            <h3>处理退货申请</h3>
        </span>
             <span class="dot-s act-3">3
            <h3>　买家退货　　</h3>
        </span>
             <span class="dot-s act-4">3
            <h3>　退货完成　　</h3>
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
         );
         ?>
         <?php if(in_array($refund_info['status'], $temp_arr)){?>
             <span class="dot">1
            <h3>买家  申请退款</h3>
        </span>
             <span class="dot act-2">2
            <h3>处理退货申请</h3>
        </span>
             <span class="dot-s act-3">3
            <h3>　买家退货　　</h3>
        </span>
             <span class="dot-s act-4">3
            <h3>　退货完成　　</h3>
        </span>
             <div class="line">
                 <div class="move-2"></div>
             </div>
         <?php }?>
         <?php
         $temp_arr=array(
             AFTERMARKET_GOODS_RETURNING,
             AFTERMARKET_REFUSE_RETURN,
             AFTERMARKET_INTERVENE,
         );
         ?>
         <?php if(in_array($refund_info['status'], $temp_arr)){?>
             <span class="dot">1
            <h3>买家  申请退款</h3>
        </span>
             <span class="dot act-2">2
            <h3>处理退货申请</h3>
        </span>
             <span class="dot act-3">3
            <h3>　买家退货　　</h3>
        </span>
             <span class="dot-s act-4">3
            <h3>　退货完成　　</h3>
        </span>
             <div class="line">
                 <div class="move-3"></div>
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
                    <div class="j-timer time" data-time="<?php echo $refund_info['countdown'];?>">
                        1天10时5分30秒
                    </div>
                    <?php if($refund_info['status']==AFTERMARKET_HANDLE){?>
                    <!-- 未处理 --><span>请处理退货</span>
                    <?php } ?>
                    <?php if($refund_info['status']==AFTERMARKET_REFUSE){?>
                    <!-- 已处理 --><span>您已拒绝退款退货申请，请等待买家回应</span>
                    <?php } ?>
                    <?php if($refund_info['status']==AFTERMARKET_AGREE){?>
                    <?php if($return_info['return_status']==0){?>
                    <!-- 等待买家退货 --> <span>等待买家退货</span>
                        <?php } ?>
                    <?php if($return_info['return_status']==1){?>
                    <!-- 买家已退货，请及时退款 --> <span>买家已退货，请及时退款</span>
                        <?php } ?>
                    <?php } ?>
                    <?php if($refund_info['status']==AFTERMARKET_SUCCESS){?>
                    <!-- 退款成功 --><span>退款成功</span>
                    <?php } ?>
                    <?php if($refund_info['status']==AFTERMARKET_INTERVENE){?>
                    <!-- 客服介入 --> <span>客服介入</span>
                    <?php } ?>
                </div>
                <?php if($refund_info['status']==AFTERMARKET_HANDLE){?>
                <!-- 未处理 -->
                <ul class="txt-tip">
                    <li>如果未发货，请点击同意退款给买家。</li>
                    <li>如果实际已发货，请主动与买家联系。</li>
                    <li>如果您逾期未响应，视作同意买家申请，系统将自动退款给买家。</li>
                    <li>如果您想拒绝退款申请，可以点击发货/拒绝退款申请，系统将关闭退款申请。</li>
                </ul>
                <div class="f-tac">
                    <button class="btn" id="J_agree" data-url="/refund/drawback_goods?rec_id=<?php echo $refund_info['rec_id'];?>">同意退货申请</button>
                </div>
                <div class="m-rsd">
                    您还可以：
                        <span class="refused" id="J_refuse">拒绝退货申请</span>
                </div>
                 <!-- 未处理 end-->
                <?php } ?>
                <!-- 已处理 -->
                <?php if($refund_info['status']==AFTERMARKET_REFUSE){?>
                <ul class="txt-tip">
                    <li>如果买家逾期未响应，系统将自动关闭退款申请。</li>
                </ul>
                <!-- 已处理 end-->
                <?php } ?>
                <?php if($refund_info['status']==AFTERMARKET_GOODS_RETURNING){?>
                <!--等待买家退货-->
                    <?php if($return_info['return_status']==0){?>
                <ul class="txt-tip">
                    <li>收到买家退货时，请及时验货及退款。</li>
                    <li>如果买家逾期未退货，退货申请将自动关闭。</li>
                </ul>
                    <?php } ?>
                <?php if($return_info['return_status']==1){?>
                <div class="m-rsd">
                    您还可以：
                        <a href="#" class="refused" id="J_refuseMoney" data-rid="<?php echo $refund_info['rec_id'];?>">已收到货，同意退款</a>　　　<a href="/refund/refused_money_back?rec_id=<?php echo $refund_info['rec_id'];?>" class="refused">拒绝退款</a>
                </div>
                <!--等待买家退货 END-->

                <!--买家已退货-->
                <ul class="txt-tip">
                    <li>如果逾期未操作，系统将自动给买家退款。</li>
                </ul>
                    <?php } ?>
                <?php } ?>
                <?php if($refund_info['status']==AFTERMARKET_REFUSE_RETURN){?>
                <!--买家已退货 END-->
                <!--收货后拒绝退款-->
                <ul class="txt-tip">
                    <li>买家修改退货申请后，需要您重新处理。</li>
                    <li>买家逾期未响应，退款退货申请将自动关闭。</li>
                </ul>
                <!--收货后拒绝退款 END-->
                <?php } ?>
                <?php if($refund_info['status']==AFTERMARKET_SUCCESS){?>
                <!-- 退款成功 -->
                <ul class="txt-tip">
                    <li>退款金额：<?php echo $refund_info['money'];?>元。</li>
                </ul>
                <!-- 退款成功 END-->
                <?php } ?>
                <?php if($refund_info['status']==AFTERMARKET_INTERVENE){?>
                <!-- 客服介入 -->
                <ul class="txt-tip">
                    <li>买家已申请客服介入，客服将于<span class="time s-fc-red" data-time="1483131517">></span>内受理。</li>
                </ul>
                <!-- 客服介入 END -->
                <?php } ?>
            </div>
            
            <div id="J_act_2" class="act" data-rid="" style="display:none">
                <div class="tip"><span>注：</span>您拒绝申请后，买家可能会要求客服介入处理，如果客服核实是您的责任，将影响您的店铺。</div>
                <div class="form-box" >
                    <dl class="clearfix">
                        <dt>拒绝原因：</dt>
                        <dd>
                            <select name="refuse_reason" id="J-type">
                                <?php foreach ($reason_info as $v){?>
                                    <option value="<?php echo $v['id'];?>"><?php echo $v['reason'];?></option>
                                <?php } ?>
                            </select>
                        </dd>
                    </dl>
                    <dl class="clearfix">
                        <dt>拒绝说明：</dt>
                        <dd>
                            <textarea rows="6" cols="60" name="supplement" id="remark" placeholder="您可以告知买家具体原因。"></textarea>
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

<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>user/js/refundGoods.js" charset="utf-8"></script>
<?php $this->load->view('footer');?>