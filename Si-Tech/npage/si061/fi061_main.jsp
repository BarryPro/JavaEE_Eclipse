<%
/**********************************
	zhangyan@2013/9/18 11:13:29
***********************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="sLoginAccept"/>
<%
String logacc = sLoginAccept;
String chnSrc = "01";
String opCode =request.getParameter("opCode");
String opName = request.getParameter("opName");
String workNo = (String)session.getAttribute("workNo");
String passwd = (String)session.getAttribute("password");
String regCode = (String)session.getAttribute("regCode");
%>    
<HTML xmlns="http://www.w3.org/1999/xhtml"> 
<HEAD>
	<TITLE><%=opName%></TITLE>
	<SCRIPT language = "javascript" type = "text/javascript" src = "/npage/public/zalidate.js"></SCRIPT>
</HEAD>
<BODY>
<FORM  NAME = "frm" ACTION = "" METHOD = "POST" ENCTYPE="multipart/form-data">
<%@ include file="/npage/include/header.jsp" %>	
<DIV ID = "Operation_Table">
	<DIV class = "title" >
		<DIV id = "title_zi"><%=opName%></DIV>
	</DIV>	
	<table>
		<tr>
			<TD ALIGN = 'CENTER' class = 'blue' >��������:</TD>
			<td>
				���룺<INPUT TYPE = 'radio' ID = '' NAME= 'opr_type' 
					VALUE = '�����ļ�' onClick = 'setImp(1)' checked/>&nbsp&nbsp&nbsp&nbsp
				��ѯ��<INPUT TYPE = 'radio' ID = '' NAME= 'opr_type' 
					VALUE = '�����ļ�' onClick = 'setImp(2)' />
			</td>
		</tr>
	</table>
	<DIV ID = "d0" NAME = "d0" STYLE = "display:none">
		<TABLE>
			<TR>
				<TD ALIGN = 'CENTER' class = 'blue' >������ˮ:</TD>
				<TD colspan = '3'>
					<input id = 'qryAcc' name = 'qryAcc' value = ''>
					<font color = 'orange' >*</font>
				</TD>      			 
			</TR>
		</table>
		<table>
			<TR>
				<TD COLSPAN = '4' ALIGN = 'CENTER' ID = 'footer'>
					<INPUT TYPE = 'BUTTON' ID = '' NAME= '' CLASS = 'b_foot' VALUE = '��ѯ' onClick = 'doQry()' />   
					<INPUT TYPE = 'BUTTON' ID = '' NAME= '' CLASS = 'b_foot' VALUE = '����' onClick = 'doRet()' />   
					<INPUT TYPE = 'BUTTON' ID = '' NAME= '' CLASS = 'b_foot' VALUE = '�ر�' onClick = 'removeCurrentTab();' />
				</TD>
			</TR>        
		</TABLE>
	</DIV>
	<DIV ID = 'queryDiv' ></DIV>
	<div  id="operation_pagination" style="display:none">
		<input id = 'succNum' name = 'succNum' value =''
			type = 'hidden' class='InputGrey' readOnly>
		<input id = 'failNum' name = 'failNum' value =''
			type = 'hidden' class='InputGrey' readOnly>
 		[<a href="#" onclick="firstPage()"> ��ҳ</a>]
		[<a href="#" onclick="pageUp()" > ��һҳ</a>]
		[<a href="#" onclick="pageDown()"> ��һҳ</a>]
		[<a href="#" onclick="lastPage()" > βҳ</a>]
		&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;
		<input readonly type="text" size="4" class="likebutton2" name="tatolPages" 
			value="1">ҳ
		&nbsp; ��ǰ��&nbsp;
		<input  readonly type="text" size="4" class="likebutton2" name="nowPage" 
			id="nowPage"  value="1">ҳ 
		&nbsp;&nbsp;ת����&nbsp;
		<input type="text" size="4" name="jump" value="1" 
			onkeydown="if(event.keyCode==13)query_jump()">ҳ
		&nbsp
		<input type="button"class="b_text" name="jump_button" value="��ת" 
			onclick="query_jump();"/>
		&nbsp;&nbsp;��&nbsp;
		<input type="text" readonly size="4" class="likebutton2" 
			name="recodeNum" value="0">����¼
	</div>		
	<div id = "d1" style = "display:none" >
		<table>
			<tr>
				<TD COLSPAN = '4' ALIGN = 'CENTER' ID = 'footer'>
					<INPUT TYPE = 'BUTTON' ID = 'getExl' NAME= 'getExl' 
						CLASS = 'b_foot' VALUE = '����EXCEL' onClick = 'doExl()' />   
				</TD>
			</tr>	
		</table>
	</div>
	<div ID = "d2" NAME = "d2"   STYLE = "display:none" >
		<table >
			<TR>
				<TD width = '50%'>
					<font color = 'red'>
						&nbsp&nbsp&nbsp&nbsp˵��:�ļ���ʽΪ:�û�����,ҵ������(5-->����乾���֣�7-->���5Ԫ�����䣩ÿ����Ϣ����"|"�ָ�.ÿ����Ϣռһ����"|"����.��:<br>
						&nbsp&nbsp&nbsp&nbsp13644603214|7|<br>
						&nbsp&nbsp&nbsp&nbsp15104568756|5|<br>
					</font> 
				</TD>

				<TD ALIGN = 'CENTER' >
					<INPUT TYPE = 'FILE' ID = 'msgf' NAME= 'msgf' />   
				</TD>
			</TR>        
		</TABLE>	
		<table >
			<TR>
				<TD COLSPAN = '4' ALIGN = 'CENTER' ID = 'footer'>
					<INPUT TYPE = 'BUTTON' ID = '' NAME= '' CLASS = 'b_foot' VALUE = 'ȷ��' onClick = 'doImp( )' />   
				</TD>
			</TR>
		</TABLE>		
	</div>			
	
	<INPUT TYPE = 'HIDDEN' ID = 'logacc' NAME = 'logacc' VALUE = '<%=logacc%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'chnSrc' NAME = 'chnSrc' VALUE = '<%=chnSrc%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'opCode' NAME = 'opCode' VALUE = '<%=opCode%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'opName' NAME = 'opName' VALUE = '<%=opName%>'/>
</DIV>
<%@ include file="/npage/include/footer_new.jsp" %>
</FORM>
<FORM  NAME = "frm1" ACTION = "" METHOD = "POST" ></form>
<SCRIPT>
function doExl()
{
	document.frm1.action="/npage/si061/fi061_exl.jsp?opCode=<%=opCode%>"
		+"&logacc="+document.all.qryAcc.value
		+"&chnSrc=<%=chnSrc%>"
		+"&workNo=<%=workNo%>"
		+"&passwd=<%=passwd%>"
		+"&phoNo="
		+"&usrPwd="
		+"&start_pos=0"
		+"&end_pos=1000";
	document.frm1.submit();
}
var recordPerPage = 50;	//ÿҳ��¼��50
var pageNumber = 1;		//��ǰҳ��
var lastNumber = 0;		//���һҳ�ļ�¼��    	

function firstPage() //��ҳ
{
	if(pageNumber-1>0)
	{
		pageNumber = 1;
		document.all.nowPage.value = pageNumber;
		document.all.jump.value = pageNumber;
		doQry(); 		
	}
}
function pageUp()
{
	if(pageNumber-1>0)
	{
		pageNumber =	pageNumber - 1;		
		document.all.nowPage.value = pageNumber;
		document.all.jump.value = pageNumber;
		doQry(); 
	}
}
function pageDown()
{
	if(pageNumber < document.frm.tatolPages.value*1)
	{
		pageNumber =	pageNumber + 1;
		
		document.all.nowPage.value = pageNumber;
		document.all.jump.value = pageNumber;
		doQry(); 
	}
}
function lastPage()
{
	if(pageNumber < document.frm.tatolPages.value*1)
	{
		pageNumber =	document.frm.tatolPages.value;
		
		document.all.nowPage.value = pageNumber;
		document.all.jump.value = pageNumber;
		doQry();
	 }
}

function query_jump()
{
	document.all.jump.value = document.all.jump.value.trim();
	if(document.all.jump.value.trim()=="")
	{
		document.all.jump.value = pageNumber;
		return false;
	}
	if(!forPosInt(document.all.jump))
	{
		document.all.jump.value = pageNumber;
		return false;
	}
	if(document.all.jump.value*1<1 || document.all.jump.value*1>document.all.tatolPages.value)
	{
		document.all.jump.value = pageNumber;
		return false;
	}
	if(document.all.jump.value != pageNumber)
	{
	pageNumber = document.all.jump.value;	
	document.all.nowPage.value = pageNumber;
	doQry();
	}
}		
	
	
var stepNum = 0;
$( document ).ready(
	function ()
	{
		$( "#d0" ).hide();
		$( "#d2" ).show( 300 );
		stepNum = stepNum + 1;
	}
);

function setImp ( i )
{
	if ( 1 == i )
	{
		$( "#msgf" ).val( "" );
		$( "#d2" ).hide();
		$( "#d0" ).hide();
		$( "#queryDiv" ).hide();
		$( "#d1" ).hide();
		$( "#operation_pagination" ).hide();
		$( "#d2" ).show( 300 );	
	}
	else if ( 2 == i )
	{
		$( "#msgf" ).val( "" );
		$( "#d2" ).hide();
		$( "#queryDiv" ).hide();
		$( "#d1" ).hide();
		$( "#operation_pagination" ).hide();
		$( "#d0" ).show( 300 );
	}

}

function doImp ()
{
	if ( $("#msgf").val() == "" )
	{
		rdShowMessageDialog( "�����ļ�����Ϊ�գ�" , 0 );
		return false;
	}
	document.frm.action = "f<%=opCode%>_cfm.jsp?logacc=<%=logacc%>"
		+"&chnSrc=<%=chnSrc%>"
		+"&opCode=<%=opCode%>"
		+"&workNo=<%=workNo%>"
		+"&passwd=<%=passwd%>"
		
		+"&phoNo="
		+"&usrPwd="
		+"&opName=<%=opName%>";	
	document.frm.submit();	
}

function doRet()
{
	document.frm.action = "#";
	document.frm.submit();	
}

function doQry ()
{
	if ( "" == $("#qryAcc").val().trim() )
	{
		rdShowMessageDialog( "������ˮ��������",0 );
		return false;
	}	
	
	$( "#d2" ).hide();
	$( "#queryDiv" ).hide();
	$( "#d1" ).hide();
	$( "#operation_pagination" ).hide();
		
	var start = (parseInt( $("#nowPage").val() , 10) -1) * recordPerPage ;

	var packet = new AJAXPacket("f<%=opCode%>_lst.jsp","���Ժ�...");
	packet.data.add( "ajaxType" , "setLst" );
	packet.data.add( "logacc" , $("#qryAcc").val().trim() );
	packet.data.add( "chnSrc" , "<%=chnSrc%>" );
	packet.data.add( "opCode" , "<%=opCode%>" );
	packet.data.add( "workNo" , "<%=workNo%>" );
                     
	packet.data.add( "passwd" , "<%=passwd%>" );
	packet.data.add( "start_pos" , start );
	packet.data.add( "end_pos" , parseInt(start , 10)+parseInt(recordPerPage ,10));

	core.ajax.sendPacketHtml(packet , setLst);//�첽

	packet =null;	
}

function setLst ( data )
{
	$( "#queryDiv" ).show();
	$( "#d1" ).show();
	$( "#operation_pagination" ).show();
	$( "#queryDiv" ).empty();
	$( "#queryDiv" ).append( data );
    var totalNum = $("#fail_num").val();
	document.all.recodeNum.value = $("#fail_num").val();
	document.all.failNum.value = $("#fail_num").val();
	document.all.succNum.value = $("#succ_num").val();
	//document.all.nowPage.value= 1;
	if ( totalNum > 1000 )
	{
		$("#getExl").attr( "disabled" , true );
	}
	else
	{
		$("#getExl").attr( "disabled" , false );	
	}
	
	//pageNumber=1;
	if(totalNum%recordPerPage==0){
		document.frm.tatolPages.value=totalNum/recordPerPage;
		lastNumber=recordPerPage;
	}else{
		document.frm.tatolPages.value=parseInt(totalNum/recordPerPage)+1;
		lastNumber=totalNum%recordPerPage;
	}     	
}
</SCRIPT>
</BODY>
</HTML>