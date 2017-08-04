<%

  /*

   * 功能: 考评项等级维护页面

　 * 版本: 1.0.0

　 * 日期: 2008/11/05

　 * 作者: mixh

　 * 版权: sitech

   * update:

　 */

%>

<%@ page contentType= "text/html;charset=GBK" %>

<%@ include file="/npage/include/public_title_name.jsp" %>

<%

	String opCode="";

	String opName="考评项等级管理";

%>



<%



String content_id = request.getParameter("content_id");

if(content_id == null || content_id == ""){

	content_id = "02";

}



String object_id = request.getParameter("object_id");

if(object_id == null || object_id == ""){

	object_id = "01";

}



String item_id = WtcUtil.repNull(request.getParameter("selectedItemId"));

item_id = item_id.split("_")[0];



String sqlStr  = "select serialno, level_name, to_number(score), is_def_level, note " + 

                 "from dqcckectitemlevel where item_id = '" + item_id + "' and object_id='" + object_id + "' and content_id='" + content_id + "' " +

                 "order by level_id";



System.out.println("############################################");

System.out.println(sqlStr);

System.out.println("############################################");

   

%>



<wtc:service name="s151Select" outnum="7">

<wtc:param value="<%=sqlStr%>"/>

</wtc:service>

<wtc:array id="queryList" scope="end"/>



<html>

<head>

<script>





function grpClose(){

window.opener = null;

window.close();

}

/**

  *

  *弹出新增考评项等级窗口

  *

  */

function show_add_item_level_win(){

	var object_id = document.getElementById("object_id").value;

	var content_id = document.getElementById("content_id").value;

	var item_id = document.getElementById("item_id").value;



	var height = 250;

	var width  = 800;

	var top    = (screen.availHeight - height)/2;

	var left   = (screen.availWidth - width)/2;

	var param  = 'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,' +

	             'width=' + width + ',height=' + height + ',left= ' + left + ',top=' + top;

	window.open('K230_add_item_level.jsp?item_id=' + item_id + "&object_id=" +object_id + "&content_id=" + content_id, '', param);

}



/**

  *

  *弹出修改考评项等级窗口

  *

  */

function show_upd_item_level_win(){

	var  serialnos = document.getElementsByName("serialno");

	var  serialno  = "";

	for(var i = 0; i < serialnos.length; i++){

		if(serialnos[i].checked){

			//alert(serialnos[i].value);

			serialno = serialnos[i].value;

		}

	}

	if(serialno == ""){

		rdShowMessageDialog("请选择想要修改的考评项等级!", 0);

		return false;

	}

	



	var height = 250;

	var width  = 800;

	var top    = (screen.availHeight - height)/2;

	var left   = (screen.availWidth - width)/2;

	var param  = 'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,' +

	             'width=' + width + ',height=' + height + ',left= ' + left + ',top=' + top;

	window.open('K230_upd_item.level.jsp?serialno=' + serialno, '', param);



}







/*对返回值进行处理*/

function doProcessDelItemLevel(packet)

{

	//alert("Begin call doProcessDelItemLevel()......");

	var retType = packet.data.findValueByName("retType");

	var retCode = packet.data.findValueByName("retCode");

	var retMsg = packet.data.findValueByName("retMsg");

	if(retType=="del_qc_item_level"){

		if(retCode=="000000"){

			//alert("成功删除考评项!");

			rdShowMessageDialog("成功删除考评项!", 2);

			var item_id    = "<%=item_id%>";

			var object_id  = "<%=object_id%>";

			var content_id = "<%=content_id%>";

			var url = "<%=request.getContextPath()%>/npage/callbosspage/checkWork/K230/K230_qc_item_level_list.jsp?selectedItemId="+item_id+"&object_id="+object_id+"&content_id="+content_id;

			window.location.href = url;

		}else{

			//alert("删除考评项失败!");

			rdShowMessageDialog("删除考评项失败!", 0);

		}

	}

	//alert("End call doProcessDelItemLevel()......");

}



/**

  *

  *删除考评项等级

  *

  */

function del_qc_item_level(){

	//alert("Begin call del_qc_item_level()....");

    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K230/K230_do_del_item_level.jsp","请稍后...");



	var  serialnos = document.getElementsByName("serialno");

	var  serialno  = "";

	for(var i = 0; i < serialnos.length; i++){

		if(serialnos[i].checked){

			serialno = serialnos[i].value;

		}

	}

	if(serialno == ""){

		rdShowMessageDialog("请选择想要删除的考评项等级!", 0);

		return false;

	}

	//alert(serialno);

    chkPacket.data.add("retType","del_qc_item_level");

    chkPacket.data.add("serialno", serialno);

    core.ajax.sendPacket(chkPacket,doProcessDelItemLevel,true);

	chkPacket =null;

	//alert("End call del_qc_item_level()....");

}





function refreshThisPage(){

	

	var item_id    = "<%=item_id%>";

	var object_id  = "<%=object_id%>";

	var content_id = "<%=content_id%>";

	var url = "<%=request.getContextPath()%>/npage/callbosspage/checkWork/K230/K230_qc_item_level_list.jsp?item_id="+item_id+"&object_id="+object+"&content_id="+content_id;

	window.location.href = url;

}



function test(){

	window.location.reload();

}

</script>

</head>

<body>

<form name="form1">

<input type="hidden" name="object_id" id="object_id" value="<%=object_id%>"/>

<input type="hidden" name="content_id" id="content_id" value="<%=content_id%>"/>

<input type="hidden" name="item_id" id="item_id" value="<%=item_id%>"/>

<%@ include file="/npage/include/header.jsp" %>

<div id="Operation_Table">

	<div class="title">查询结果</div>

	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">

    <tr> 

    	 <th>选择</th>

    	 <th>编号</th>

         <th>名称</th>

         <th>分数</th>

         <th>是否为默认得分</th>

         <th>描述</th>

    </tr>

    <%

    for(int i = 0; i < queryList.length; i++){

    %>

    <tr>

    	<td<%if(i%2==0){out.println(" class='Grey'");}%>>

    	<input type="radio" name="serialno" value="<%=queryList[i][0]%>"/>

    	</td>

		<td<%if(i%2==0){out.println(" class='Grey'");}%>><%=queryList[i][0]%>&nbsp;</td>

		<td<%if(i%2==0){out.println(" class='Grey'");}%>><%=queryList[i][1]%>&nbsp;</td>

		<td<%if(i%2==0){out.println(" class='Grey'");}%>><%=queryList[i][2]%>&nbsp;</td>

		<td<%if(i%2==0){out.println(" class='Grey'");}%>><%if(queryList[i][3].equals("N")){out.println("否");}else{out.println("是");}%>&nbsp;</td>

		<td<%if(i%2==0){out.println(" class='Grey'");}%>><%=queryList[i][4]%>&nbsp;</td>

    </tr>

    <%

    }

    %>

	</table>





	<TABLE width="100%" border="0" cellpadding="0" cellspacing="0">

		<tr>

			<td align="center" id="footer">

				<input name="confirm" onClick="show_add_item_level_win();" type="button" class="b_foot" value="新增">

				<input name="confirm" onClick="show_upd_item_level_win();" type="button" class="b_foot" value="修改">

				<input name="confirm" onClick="del_qc_item_level();" type="button" class="b_foot" value="删除">

				<input class="b_foot" name="back" type="button" onclick="grpClose();" value="关闭"  >



			</td>

		</tr>

	</TABLE>







<%@ include file="/npage/include/footer.jsp" %>



</form>

</body>

</html>



<script language="javascript">





function cfm(){

	if(check(document.form1)){

		form1.action="sample2.jsp";

		form1.submit();

	}

}



function ccc(){

	if(rdShowConfirmDialog("是否确定提交？")){



	}



}



</script>

