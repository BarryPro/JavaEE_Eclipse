<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ����ϵ������ fb901
   * �汾: 1.0
   * ����: 2010/11/30
   * ����: wanglm
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%	request.setCharacterEncoding("GBK");%>
<%!
		    public static String createArray(String aimArrayName, int xDimension) {
		        String stringArray = "var " + aimArrayName + " = new Array(";
		        int flag = 1;
		        for (int i = 0; i < xDimension; i++) {
		            if (flag == 1) {
		                stringArray = stringArray + "new Array()";
		                flag = 0;
		                continue;
		            }
		            if (flag == 0) {
		                stringArray = stringArray + ",new Array()";
		            }
		        }
		
		        stringArray = stringArray + ");";
		        return stringArray;
		    }
		%>
<%
    String opCode="b902";
	String opName="������Ӫ���ݷ���";
	String workNo = (String)session.getAttribute("workNo");
	String[][] result = (String[][])request.getAttribute("result");
	String reMsg = createArray("servArr", result.length); 
	for(int i=0;i<result.length;i++){
	  for(int j=0;j<result[i].length;j++){
	    System.out.println("..................................................result["+i+"]["+j+"]  " + result[i][j]);
	 }
	}
	
	System.out.println("..................................................reMsg    " + reMsg);
%>     
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>������Ӫ���ݷ���</TITLE>
</HEAD>
<script type="text/javascript" src="jscharts.js"></script>
<script type="text/javascript" src="drawline.js"></script>
<script type="text/javascript">
	<%=reMsg%>
	function draw(){
		<%
			    for (int p = 0; p < result.length; p++) {
			        for (int q = 0; q < result[p].length; q++) {
			           if(q == 0){
			%>
						servArr[<%=p%>][<%=q%>]="<%=result[p][q]%>";
			<%         }else{  
				%>
				        servArr[<%=p%>][<%=q%>]=parseInt("<%=result[p][q]%>");//JS ����
				<%
				        }
			        }
			    }
			%>
	   	drawLine(servArr,9,1);
	}
</script>
<body onload="draw()">
	<FORM method="post" name="form1" action="">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
    	<div id="title_zi">������Ӫ���ݷ���</div>
    </div>
    <center>
	<div id="graph"></div>
	<table cellSpacing="0">
    	<font color="red">*��ʾ�����������ȡ�����������������ʱ�䣬������ƶ���ԭ���Ͽɲ鿴��Ӧʱ���ȡ��������</font>
    	<tr>
			<td colspan="7" align="center" id="footer">
			<input class="b_foot" name="re"    type="button" onClick="javascript:history.go(-1);" value="����"/>
			<input class="b_foot" name="back"    type="button" onClick="removeCurrentTab()" value="�ر�"/>
			</td>
		</tr>
    </table>
	<center>
    <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
    		
    			