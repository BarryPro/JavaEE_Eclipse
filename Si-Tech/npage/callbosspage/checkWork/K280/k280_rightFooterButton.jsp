<%
  /*
   * ����: �ʼ�Ȩ�޹���->ά�����칤�ź���->���¹�����
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����: mixh
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%@ page language="java" pageEncoding="gbk"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<HTML>
	<HEAD>
	</HEAD>
	<BODY>
<div id="div1" style="display: none" >
		<TABLE width="100%"  height="25" cellSpacing="0" vAlign=top>
			<TR>
				<TD>
					<input type="button" class="b_text"  onclick="showCheckItemWin()" value="��Χѡ��"/>
					<input type="button" class="b_text" onclick="clearAll('loginNo')" value="ȫ�����"/>
					<input type="button" class="b_text"  onclick="checkAll('loginNo')" value="ȫ��ѡ��"/>
					<input type="button" class="b_text" onclick="memberMsgWin()" value="��ѯ��Ա��Ϣ"/>
					<!--
					<input type="button" class="b_text" onclick="beforeLoad();" value="���뱻�칤��"/>
					<input type="button" class="b_text" onclick="beforeLoadSerialNo()" value="���뱻����ˮ"/>
					-->
					<!--input type='file' id='impFileid' name='impFileid' class="b_text" > <input type='button' name='upload' value='�ύ' class="b_text" onClick='importSubmit();'/><font color='red'>&nbsp;�ļ��ļ���С<5M</font-->
						
				<TD align="left">
					<input type="button" id="saveBtn" class="b_text" onclick="saveChange()" value="����"/>
				</TD>
			</TR>
		</TABLE>
	</div>
</html>
<SCRIPT type=text/javascript> 

//���뵼�빤��ѡ��·��ҳ��	
function beforeLoad(){
		var selectedItemId = parent.frameleft.window.tree.getSelectedItemId();
		if(selectedItemId == "undefined" || "" == selectedItemId){
				similarMSNPop("����ѡ��Ҫ���빤�ŵı����飡");
				return false ;
		}
		var itemName = parent.frameleft.window.tree.getItemText(selectedItemId);
		if(rdShowConfirmDialog("�ظ�����ֻ����һ��,ȷ�����빤�ŵ������顾"+itemName+"����ô��") == 1){
			
			var time = new Date();
			var path='<%=request.getContextPath()%>/npage/callbosspage/checkWork/K280/K280_loadPage.jsp?now=' + time;
			path = path + '&selectedItemId=' + selectedItemId;
				
			var Height = window.screen.availHeight - 500; 
			var width  = window.screen.availWidth  - 500;
			var top    = (window.screen.availHeight-30 - Height)/2; //��ô��ڵĴ�ֱλ��;
			var left   = (window.screen.availWidth-10 - width)/2; //��ô��ڵ�ˮƽλ��;
			var param  = 'height=' + Height + ',width=' + width + ',top=' + top + ',left=' + left + 
			             ',toolbar=no,menubar=no,scrollbars=yes,resizable=yes,location=no,status=no';
			
			window.open(path, '���빤��', param);	
			//window.open("K280_loadPage.jsp?selectedItemId="+selectedItemId,'���빤��',250,550);
		}
}
//���뵼����ˮѡ��·��ҳ��
function beforeLoadSerialNo(){
		var selectedItemId = parent.frameleft.window.tree.getSelectedItemId();
		if(selectedItemId == "undefined" || "" == selectedItemId){
				similarMSNPop("����ѡ��Ҫ������ˮ�ı����飡");
				return false ;
		}
		var itemName = parent.frameleft.window.tree.getItemText(selectedItemId);
		if(rdShowConfirmDialog("�ظ���ˮ��ֻ����һ��,�������ˮ��������ͬһ�·�,ȷ��������ˮ�������顾"+itemName+"����ô��") == 1){
			
			var time = new Date();
			var path='<%=request.getContextPath()%>/npage/callbosspage/checkWork/K280/K280_loadSerialPage.jsp?now=' + time;
			path = path + '&selectedItemId=' + selectedItemId;
				
			var Height = window.screen.availHeight - 500; 
			var width  = window.screen.availWidth  - 500;
			var top    = (window.screen.availHeight-30 - Height)/2; //��ô��ڵĴ�ֱλ��;
			var left   = (window.screen.availWidth-10 - width)/2; //��ô��ڵ�ˮƽλ��;
			var param  = 'height=' + Height + ',width=' + width + ',top=' + top + ',left=' + left + 
			             ',toolbar=no,menubar=no,scrollbars=yes,resizable=yes,location=no,status=no';			
			window.open(path, '������ˮ��', param);
		}
}
function showTable(){
var odiv = document.getElementById('div1');
odiv.style.display ="block";
}
//����������
function hiddenTable(){
var odiv = document.getElementById('div1');
odiv.style.display ="none";

}
function clearAll(){
	parent.frameright.window.clearAll('loginNo');
}
function checkAll(){
	parent.frameright.window.checkAll('loginNo');
	}
	
/**
  *���汻�ʼ����Ա��Ϣ
  */
function saveChange(){
	parent.frameright.window.saveChange();
}

function showCheckItemWin(){
	parent.frameright.window.showCheckItemWin();
	}	
function cancel(){
	parent.frameright.window.cancel();
}	
function memberMsgWin(){
	parent.frameright.window.memberMsgWin();
	}
showTable();
</SCRIPT>
	
