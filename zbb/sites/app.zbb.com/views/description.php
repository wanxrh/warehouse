<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;" />
    <title> </title>
    <link rel="stylesheet" href="<?php echo $this->config->item('domain_static'); ?>app/css/main.css">
</head>
<body>
<div id="apppanl">
    <?php echo isset($detail)?$detail:'';?>
</div>
<script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>common/js/jquery-1.11.0.min.js" charset="utf-8"></script>
<script type="text/javascript">
    function init(){
       $('#apppanl').find('table,img,div').css({'width':'100%', 'margin':'0','height':'auto'});
    };
    $(function(){
        init();
    })
</script>
</body>
</html>
