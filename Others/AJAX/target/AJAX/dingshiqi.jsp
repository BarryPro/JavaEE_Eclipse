<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title></title>
    <script type="text/javascript" src="js/jquery-1.11.0.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            $("#btn1").click(function(){
                $("#label1").attr("style","display:none");
            })
            $("#btn2").click(function(){
                $("#label1").attr("style","display:block");
            })
            $("#submit").click(function(){
                setTimeout('$("#label1").attr("style","display:none")',3000);
            })
            $("#btn4").click(function(){
                setTimeout('$("#label1").attr("style","display:none")',3000);
            })


        })
        function submit(){
//            document.all.aaa.submit();
            document.getElementById("aaa").submit();
        }
    </script>
</head>
<body>
<form action="#" id="aaa">
    <input type="button" value="消失" id="btn1"/><br/>
    <input type="button" value="出现" id="btn2"/><br/>
    <input type="button" value="submit" id="btn3" onclick="submit()"/><br/>
    <a href="#" onclick="submit()" id="btn4">登录</a>
    <label id="label1">belong</label><br/>
</form>
</body>
</body>
</html>