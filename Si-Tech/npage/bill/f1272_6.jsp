<%
    /********************
     version v2.0
     ������: si-tech
     *
		 *update:zhanghonga@2008-08-27 ҳ�����,�޸���ʽ
		 *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

	
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<%
		String opCode = "1272";
		String opName = "��ѡ�ʷѱ��";
		
		String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
		String op_code = "1272";                                                //��������
		String cust_id = WtcUtil.repNull(request.getParameter("cust_id"));                        //�ͻ�ID
		String maincash_no = WtcUtil.repNull(request.getParameter("maincash_no"));                //���ʷѴ���
		String newcash_no = WtcUtil.repNull(request.getParameter("ip"));                          //�����ʷѴ���
		String belong_code = WtcUtil.repNull(request.getParameter("belong_code"));                //belong_code
		String temmode_type = WtcUtil.repNull(request.getParameter("mode_type"));
		String mode_type = temmode_type.substring(0,4);
		String sendflag = WtcUtil.repNull(request.getParameter("sendflag"));											//��Ч��ʽ
		String mode_name = WtcUtil.repNull(request.getParameter("mode_name"));                     //�ײ�����
		String loginNo =(String)session.getAttribute("workNo"); 
		String ret_code="";
		String ret_msg="";
		String minopen= WtcUtil.repNull(request.getParameter("minopen"));							//�õ������С��ͨ��
		String maxopen= WtcUtil.repNull(request.getParameter("maxopen"));
  //the1270InitList = callView.s1272InitProcess(op_code, cust_id,maincash_no,belong_code ,mode_type,mode_name).getList();
  /************************************************************************
		@wt ��������: s1272Init
		@wt ����ʱ��: 2003/11/23
		@wt ������Ա: wangtao
		@wt ��������: ���ײͱ��ʱ�����������ȡ���Ŀ�ѡ�ײ�
		@wt �������: 0 ��������            iLoginNo
		@wt           1 �û�ID              iIdNo
		@wt           2 �����ʷ��ײʹ���    iOldMode
		@wt           3 belong_code         iBelongCode
		@wt           4 ��ѡ�ײ�������    iModeType
		@wt           5 ��ѡ�ײ��������    iModeTypeName
		@wt �������: 0 ���ش���
		@wt           1 ������Ϣ
		@wt ----------------------------------------------------
		@wt           2 ��ѡ�ײ�����            oModeName
		@wt           3 ��ѡ�ײ�״̬            oModeStatus
		@wt           4 ��ѡ�ײͿ�ʼʱ��        oTmBegin
		@wt           5 ��ѡ�ײͽ���ʱ��        oTmEnd
		@wt           6 ��ѡ�ײ͵����          iModeTypeName
		@wt           7 ��ѡ�ײ���Ч��ʽ        oSendFlagName 
		@wt           8 ��ѡ�ײ�choiced_flag    oModeChoicedName
		@wt ----------------------------------------------------
		@wt           9 ��ѡ�ײʹ���            oModeCode
		@wt          10 ��ѡ�ײ͵����          iModeType
		@wt          11 ��ѡ�ײ���Ч��ʽ        oSendFlag 
		@wt          12 ��ѡ�ײ�ԭ��ͨ��ˮ      oOldAccept
		@wt          13 ��ѡ�ײ�choiced_flag    oModeChoiced
		@wt          14 ��ѡ�ײͱ�ע            oModeNote
		@wt  [c ����Ч��ʽ�����ʱ���ͻ����������/0 ����]
	************************************************************************/
%>

	<wtc:service name="s1272InitNew" routerKey="region" routerValue="<%=regionCode%>" outnum="15" >
	<wtc:param value="<%=loginNo%>"/>
	<wtc:param value="<%=cust_id%>"/>
	<wtc:param value="<%=maincash_no%>"/>
	<wtc:param value="<%=belong_code%>"/>
	<wtc:param value="<%=mode_type%>"/>
	<wtc:param value="<%=mode_name%>"/>
	</wtc:service>
	<wtc:array id="result3" start="0" length="2" scope="end"/>		
	<wtc:array id="mainResultArr" start="2" length="13" scope="end"/>
<%
			if(result3!=null&&result3.length>0){
				  ret_code = result3[0][0].trim();//�������
				  ret_msg = result3[0][1];        //������Ϣ
				  //maxopen = result3[0][2].trim();//���ͨ�� //��Ϊ���صĲ���û��ʲô���ͨ��,����ע�͵�
				  //minopen = result3[0][3].trim();//��С��ͨ�� //��Ϊ���صĲ���û��ʲô��С��ͨ��,����ע�͵�
			}


      if(ret_msg.equals("")){
          ret_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(ret_code));
          if( ret_msg.equals("null")){
              ret_msg ="δ֪������Ϣ";
          }
      }
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
    <TITLE>
        ��ѡ�ײ���ϸ
    </TITLE>
    <script language="javascript">
		    /*----------------------------��ҳ��ѡ�����ݽ��д���--------------------------------*/
		    function returndata()
		    {
		        var end = "";
		        var obj = "";
		        var thestr = "";
		
		        for (var i = 1; i < document.all.checkId.length; i++)
		        {
		            if (document.all.checkId[i].checked == true)
		            {
		
		                thestr = thestr + document.all.Rinput1[i].value + "|";
		                thestr = thestr + document.all.Rinput2[i].value + "|";
		                thestr = thestr + document.all.Rinput3[i].value + "|";
		                thestr = thestr + document.all.Rinput4[i].value + "|";
		                thestr = thestr + document.all.Rinput5[i].value + "|";
		                thestr = thestr + document.all.Rinput6[i].value + "|";
		                thestr = thestr + document.all.Rinput7[i].value + "|";
		                thestr = thestr + document.all.Rinput8[i].value + "|";
		                thestr = thestr + document.all.Rinput9[i].value + "|";
		                thestr = thestr + document.all.Rinput10[i].value + "|";
		                thestr = thestr + document.all.Rinput11[i].value + "|";
		                thestr = thestr + document.all.Rinput12[i].value + "|";
		                if (document.all.Rinput13[i].value == "") {
		                    thestr = thestr + "��������Ϣ" + "|";
		                } else {
		                    thestr = thestr + document.all.Rinput13[i].value + "|";
		                }
		            }
		        }
		        end = thestr;
		        window.returnValue = end;
		        window.close();
		    }
		    function maxopen()
		    {
		        var flag = 0;
		        var maxopen = '<%=maxopen%>';
		        var minopen = '<%=minopen%>';
		        for (var z = 1; z < document.all.checkId.length; z++)
		        {
		            if (document.all.checkId[z].checked == true)
		            {
		                flag++;
		            }
		        }
		        if (flag > maxopen || flag < minopen) {//���յĿ�ͨ�������ͨ���Ƚ�
		            rdShowMessageDialog("���ο�ͨ��Ϊ'" + flag + "'Ӧ��'" + minopen + "'��'" + maxopen + "'֮�䣡");
		            return false;
		        }
		        else {
		            return true;
		        }
		    }
		</script>
</HEAD>

<body>
<%@ include file="/npage/include/header_pop.jsp" %>
<TABLE id=thetab cellSpacing="0">
    <tr align="center">
        <th>ѡ��</th>
        <th>��ѡ�ײ�����</th>
        <th>״̬</th>
        <th>��ʼʱ��</th>
        <th>����ʱ��</th>
        <th>�ײ����</th>
        <th>��Ч��ʽ</th>
        <th>��ѡ��ʽ</th>
    </tr>
    <tr style="display:none" align="center">
        <td><input type="checkbox" name="checkId" id="checkId"></td>
        <td>
            <div align="center"><input type="text" id="Rinput1" value=""></div>
        </td>
        <td>
            <div align="center"><input type="text" id="Rinput2" value=""></div>
        </td>
        <td>
            <div align="center"><input type="text" id="Rinput3" value=""></div>
        </td>
        <td>
            <div align="center"><input type="text" id="Rinput4" value=""></div>
        </td>
        <td>
            <div align="center"><input type="text" id="Rinput5" value=""></div>
        </td>
        <td>
            <div align="center"><input type="text" id="Rinput6" value=""></div>
        </td>
        <td>
            <div align="center">
            		<input type="text" id="Rinput7" value="">
                <input type="text" id="Rinput8" value="">
                <input type="text" id="Rinput9" value="">
                <input type="text" id="Rinput10" value="">
                <input type="text" id="Rinput11" value="">
                <input type="text" id="Rinput12" value="">
                <input type="text" id="Rinput13" value="">
            </div>
        </td>
    </tr>

    <!----------------------------------------------------------------------->
<%     
    if(!ret_code.trim().equals("000000")&&!ret_code.equals("17022")){
%>
			<tr align="center">
				<td colspan="8"><font class="orange">��ѯ���󣡷�����룺<%=ret_code%>��������Ϣ��<%=ret_msg%>��</font></td>
			</tr>
<%
		}else{
        String[][] data = new String[][]{};
        data = mainResultArr;
				String tbclass="";
        for (int y = 0; y < data.length; y++) {
        		if(y%2==0){
        			tbclass = "Grey";
        		}else{
        			tbclass = "";	
        		}
                String addstr = data[y][0] + "#" + data[y][1] + "#" + y;
    %>
    <tr align="center">
        <%if (data[y][data[0].length - 2].equals("0")) {//�ɸĲ�ѡ��%>
        <td class="<%=tbclass%>"><input type="checkbox" name="checkId" value="<%=addstr%>"></td>

        <%
            }
            if (data[y][data[0].length - 2].equals("c")) {//���ɸĲ�ѡ��
        %>
        <td class="<%=tbclass%>">
        	<input type="checkbox" name="checkId" value="<%=addstr%>" onclick="if(document.all.checkId[<%=y%>+1].checked==true){document.all.checkId[<%=y%>+1].checked=false;}rdShowMessageDialog('����Ч��ʽ�����ʱ���ͻ����������!');return false;">
        </td>

        <% 
        		}
        		
            for (int j = 0; j < data[0].length; j++) {
                System.out.println("data["+y+"]["+j+"]=="+data[y][j]);
                String tbstr = "";
                if (j == 1) {
                    String habitus = "";
                    if (data[y][j].trim().equals("Y")) habitus = "�ѿ�ͨ";
                    if (data[y][j].trim().equals("N")) habitus = "δ��ͨ";
                    tbstr = "<TD class='"+tbclass+"'>" + habitus + "<input type='hidden' " +
                            " id='Rinput" + (j + 1) + "' name='Rinput" + (j + 1) + "' class='button' value='" +
                            (data[y][j]).trim() + "'readonly></TD>";
                } else if (j > 6) {
                    tbstr = " <input type='hidden' " +
                            " id='Rinput" + (j + 1) + "' name='Rinput" + (j + 1) + "' class='button' value='" +
                            (data[y][j]).trim() + "'readonly>";
                } else {
                    tbstr = "<TD class='"+tbclass+"'>" + data[y][j].trim() + "<input type='hidden' " +
                            " id='Rinput" + (j + 1) + "' name='Rinput" + (j + 1) + "' class='button' value='" +
                            (data[y][j]).trim() + "'readonly></TD>";
                }
                out.println(tbstr);
        %>

        <%
            }
        %>
    </tr>
<%
       }
     }
%>
    <input type="hidden" name="maxopen" value="<%=maxopen%>">
    <input type="hidden" name="minopen" value="<%=minopen%>">
</TABLE>
<TABLE cellSpacing="0">
    <TBODY>
        <TR>
            <TD id="footer">
                <input class="b_foot" name=sure type=button value=ȷ�� onclick="if(maxopen()) returndata();">
                <input class="b_foot" name=close type=button value=�ر� onclick="window.close()">
            </TD>
        </TR>
    </TBODY>
</TABLE>
<%@ include file="/npage/include/footer_pop.jsp" %>
<body>
</html>

