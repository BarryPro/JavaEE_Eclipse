<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page  contentType="text/html;charset=gb2312" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%
	String opCode = "e493";
	String opName = "ͳ�Ʒ���";
	
	String  powerCode = session.getAttribute("powerCode")==null?"":((String)session.getAttribute("powerCode")).trim();//��ɫ����
	String orgCode =  (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String workNo = (String)session.getAttribute("workNo");	
	
	SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
	String currentTime = fmt.format(new Date());
%>

	<head>
		<title><%=opName%></title>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<META content=no-cache http-equiv=Pragma>
		<META content=no-cache http-equiv=Cache-Control>
		<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
		<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/My97DatePicker/WdatePicker.js"></script>
  	<script language="JavaScript" src="<%=request.getContextPath()%>/njs/extend/FusionCharts.js"></script>
  	</head>
	
	<script>
	
		//ѡ��ͳ������
		function selectType(stats_type){
				  if(typeof(stats_type)=="undefined" || stats_type==""){
				  	stats_type = $("#stats_type").val();
					}
					var statsDate = $("#stats_date").val();
				    var path = "stats_charts.jsp";
				  
					var selectPacket = new AJAXPacket(path,"���ڼ���,���Ժ�...");
					selectPacket.data.add("statsDate", statsDate);
					selectPacket.data.add("stats_type", stats_type);
			      	core.ajax.sendPacketHtml(selectPacket,doSelectType,true);
			      	selectPacket = null; 
			  
		}
		
		function doSelectType(data)      
 		{
	       $('#stats_content').html(data);
     }

function selectOpType(tv){
	if(tv=="b"){
		if($("#stats_type").val()=="0"){
		$("#tTr").hide();
		$("#bTr").hide();
		}else{
			if($("input:radio[name='opt_type']:checked").val()=="t"){//ͼ��
				$("#tTr").show();
				$("#bTr").hide();
			}else{
				$("#bTr").show();
				$("#tTr").hide();
			}
		}
		$("#bFoot").val("��ʾ����");
	}else{
		if($("#stats_type").val()=="0"){
		$("#tTr").hide();
		$("#bTr").hide();
		}else{
			if($("input:radio[name='opt_type']:checked").val()=="t"){//ͼ��
				$("#tTr").show();
				$("#bTr").hide();
			}else{
				$("#bTr").show();
				$("#tTr").hide();
			}
		}
		$("#bFoot").val("��ʾͼ��");
	}
	
	$('#stats_content').html("");
	$("#frame_content").hide();
	$("#frame_content").attr("src","");
}

$(document).ready(function(){
	selectOpType();
	setDataShow();
});
function showbbf(){
	
	if($("#stats_type").val()!="0"){
	 if(parseInt(document.all.be_date.value)>parseInt(document.all.en_date.value)){
	 	rdShowMessageDialog("��ʼ���ڲ��ܴ��ڽ������ڣ�����������");
	 	return;
	 }
	}
	//alert("stats_type|"+$("#stats_type").val());
	 $("#frame_content").attr("src","showBbj.jsp?beDate="+$("#be_date").val()+"&enDate="+$("#en_date").val()+"&statstype="+$("#stats_type").val());
	 $("#frame_content").show();
	 var iframe = document.getElementById("frame_content");
	iframe.height =  iframe.contentWindow.document.documentElement.scrollHeight;
}
 
function showBf(){
	if($("input:radio[name='opt_type']:checked").val()=="t"){//ͼ��
		selectType();
	}else{//����
		showbbf();
	}
}
function setDataShow(){
	if($("#stats_type").val()=="0"){
		$("#tTr").hide();
		$("#bTr").hide();
	}else{
		if($("input:radio[name='opt_type']:checked").val()=="t"){//ͼ��
			$("#tTr").show();
		}else{
			$("#bTr").show();
		}
	}
}
	</script>
	<body>
		
		<form name="" action="" method=post>
			<%@ include file="/npage/include/header_mop.jsp"%>
					
					<div class="title"> 
							<div id="title_zi">
								ͳ�Ʒ���
							</div>							
					</div>
					<table cellspacing="0">
						<tr>
							<td class="blue">��������</td>
							<td  class="blue">
								<input type="radio" name="opt_type" id="opt_type" value="t"  checked onclick="selectOpType(this.value)"/>ͼ��ͳ��
								<input type="radio" name="opt_type" id="opt_type" value="b"  onclick="selectOpType(this.value)"/>����ͳ��
							</td>
							
							
							<td class="blue" width="10%">
									ͳ������
								</td>
								<td class="blue">
									<select id="stats_type" name="stats_type" onchange="setDataShow()">
										<option value="0" >
											��������ͳ��
										</option>										
										<option value="1" >
											����ʱ��ͳ��
										</option>
										<option value="2" >
											����̨ʹ��Ƶ��ͳ��
										</option>
									</select>
								</td>
						</tr>
						
						
						<tr id="bTr">
								
								
								<td class="blue" width="10%">
									��ʼ����
								</td>
								<td class="blue"  >
									<input type="text" id="be_date" onfocus="WdatePicker({dateFmt:'yyyyMMdd',autoPickDate:true})" value="<%=currentTime%>" />
								</td>
								
								<td class="blue" width="10%">
									��������
								</td>
								<td class="blue" >
									<input type="text" id="en_date" onfocus="WdatePicker({dateFmt:'yyyyMMdd',autoPickDate:true})" value="<%=currentTime%>" />
								</td>
							</tr>
						<tr id="tTr">
								
								
								<td class="blue" width="10%">
									ͳ������
								</td>
								<td class="blue" colspan=3>
									<input type="text" id="stats_date" onfocus="WdatePicker({dateFmt:'yyyyMMdd',autoPickDate:true})" value="<%=currentTime%>" />
								</td>
							</tr>
							
							
							<tr>
								<td colspan="4" id="footer">
									<input type="button" value="��ʾͼ��" class="b_foot_long" id="bFoot" onclick="showBf()">
									</td>
							</tr>
						</table>	
						</div>
					
					   <div id="stats_content"></div>
					   <iframe src=""; id="frame_content" name="frame_content" width="1050" height="400"   frameborder="0"> </iframe> 
			<%@ include file="/npage/include/footer.jsp"%>
		</form>
	</body>
</html>
