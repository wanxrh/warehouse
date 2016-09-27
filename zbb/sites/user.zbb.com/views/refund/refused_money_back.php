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
  
</style>
<div class="g-wrap clearfix">
    <div class="m-step">
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
    </div>
</div>
<div class="g-wrap clearfix m-refund">
    <div class="g-mn">
        <div class="g-mnc">
            <div class="act" data-rid="">
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
<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>common/js/jquery-1.11.0.min.js" charset="utf-8"></script>
<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>common/js/webuploader/webuploader.js"></script>
<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>user/js/upload_back.js"></script>

<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>user/js/refundBack.js" charset="utf-8"></script>
<?php $this->load->view('footer');?>