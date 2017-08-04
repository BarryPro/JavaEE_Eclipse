<%
    /********************
     version v2.0
     开发商: si-tech
     *
		 *update:zhanghonga@2008-08-27 页面改造,修改样式
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
		String opName = "可选资费变更";
		
		String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
		String op_code = "1272";                                                //操作代码
		String cust_id = WtcUtil.repNull(request.getParameter("cust_id"));                        //客户ID
		String maincash_no = WtcUtil.repNull(request.getParameter("maincash_no"));                //主资费代码
		String newcash_no = WtcUtil.repNull(request.getParameter("ip"));                          //新主资费代码
		String belong_code = WtcUtil.repNull(request.getParameter("belong_code"));                //belong_code
		String temmode_type = WtcUtil.repNull(request.getParameter("mode_type"));
		String mode_type = temmode_type.substring(0,4);
		String sendflag = WtcUtil.repNull(request.getParameter("sendflag"));											//生效方式
		String mode_name = WtcUtil.repNull(request.getParameter("mode_name"));                     //套餐名称
		String loginNo =(String)session.getAttribute("workNo"); 
		String ret_code="";
		String ret_msg="";
		String minopen= WtcUtil.repNull(request.getParameter("minopen"));							//得到最大，最小开通数
		String maxopen= WtcUtil.repNull(request.getParameter("maxopen"));
  //the1270InitList = callView.s1272InitProcess(op_code, cust_id,maincash_no,belong_code ,mode_type,mode_name).getList();
  /************************************************************************
		@wt 服务名称: s1272Init
		@wt 编码时间: 2003/11/23
		@wt 编码人员: wangtao
		@wt 功能描述: 主套餐变更时，可以申请和取消的可选套餐
		@wt 输入参数: 0 操作工号            iLoginNo
		@wt           1 用户ID              iIdNo
		@wt           2 现主资费套餐代码    iOldMode
		@wt           3 belong_code         iBelongCode
		@wt           4 可选套餐类别代码    iModeType
		@wt           5 可选套餐类别名称    iModeTypeName
		@wt 输出参数: 0 返回代码
		@wt           1 返回信息
		@wt ----------------------------------------------------
		@wt           2 可选套餐名称            oModeName
		@wt           3 可选套餐状态            oModeStatus
		@wt           4 可选套餐开始时间        oTmBegin
		@wt           5 可选套餐结束时间        oTmEnd
		@wt           6 可选套餐的类别          iModeTypeName
		@wt           7 可选套餐生效方式        oSendFlagName 
		@wt           8 可选套餐choiced_flag    oModeChoicedName
		@wt ----------------------------------------------------
		@wt           9 可选套餐代码            oModeCode
		@wt          10 可选套餐的类别          iModeType
		@wt          11 可选套餐生效方式        oSendFlag 
		@wt          12 可选套餐原开通流水      oOldAccept
		@wt          13 可选套餐choiced_flag    oModeChoiced
		@wt          14 可选套餐备注            oModeNote
		@wt  [c 因生效方式与结束时间冲突而不能申请/0 正常]
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
				  ret_code = result3[0][0].trim();//错误代码
				  ret_msg = result3[0][1];        //错误信息
				  //maxopen = result3[0][2].trim();//最大开通数 //因为返回的参数没有什么最大开通数,所以注释掉
				  //minopen = result3[0][3].trim();//最小开通数 //因为返回的参数没有什么最小开通数,所以注释掉
			}


      if(ret_msg.equals("")){
          ret_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(ret_code));
          if( ret_msg.equals("null")){
              ret_msg ="未知错误信息";
          }
      }
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
    <TITLE>
        可选套餐明细
    </TITLE>
    <script language="javascript">
		    /*----------------------------对页面选中数据进行传输--------------------------------*/
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
		                    thestr = thestr + "无描述信息" + "|";
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
		        if (flag > maxopen || flag < minopen) {//最终的开通数与最大开通数比较
		            rdShowMessageDialog("本次开通数为'" + flag + "'应在'" + minopen + "'－'" + maxopen + "'之间！");
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
        <th>选择</th>
        <th>可选套餐名称</th>
        <th>状态</th>
        <th>开始时间</th>
        <th>结束时间</th>
        <th>套餐类别</th>
        <th>生效方式</th>
        <th>可选方式</th>
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
				<td colspan="8"><font class="orange">查询错误！服务代码：<%=ret_code%>。服务信息：<%=ret_msg%>。</font></td>
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
        <%if (data[y][data[0].length - 2].equals("0")) {//可改不选中%>
        <td class="<%=tbclass%>"><input type="checkbox" name="checkId" value="<%=addstr%>"></td>

        <%
            }
            if (data[y][data[0].length - 2].equals("c")) {//不可改不选中
        %>
        <td class="<%=tbclass%>">
        	<input type="checkbox" name="checkId" value="<%=addstr%>" onclick="if(document.all.checkId[<%=y%>+1].checked==true){document.all.checkId[<%=y%>+1].checked=false;}rdShowMessageDialog('因生效方式与结束时间冲突而不能申请!');return false;">
        </td>

        <% 
        		}
        		
            for (int j = 0; j < data[0].length; j++) {
                System.out.println("data["+y+"]["+j+"]=="+data[y][j]);
                String tbstr = "";
                if (j == 1) {
                    String habitus = "";
                    if (data[y][j].trim().equals("Y")) habitus = "已开通";
                    if (data[y][j].trim().equals("N")) habitus = "未开通";
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
                <input class="b_foot" name=sure type=button value=确认 onclick="if(maxopen()) returndata();">
                <input class="b_foot" name=close type=button value=关闭 onclick="window.close()">
            </TD>
        </TR>
    </TBODY>
</TABLE>
<%@ include file="/npage/include/footer_pop.jsp" %>
<body>
</html>

