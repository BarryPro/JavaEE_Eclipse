 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-02-12 ҳ�����,�޸���ʽ
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    String opCode = "3075";
	String opName = "������BOSS-��������";	//header.jsp��Ҫ�Ĳ���

	String workno = (String)session.getAttribute("workNo");
	String regioncode=(String)session.getAttribute("regCode");
	String orgcode = (String)session.getAttribute("orgCode");
    String dateStr=new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());

    String opcd = "3075"  ;
    String op_name = "������BOSS-��������";

%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regioncode%>"  id="sysAccept" />
<script language="JavaScript"  src="/page/s1300/common_1300.js"></script>
<HTML>
	<HEAD>
		<TITLE><%=op_name%></TITLE>
		<script language="JavaScript">
		<!--
		function doCommit()
		{
		        var count=parseInt(form.lines.value);
		        var count1=parseInt(form.lines1.value);
		        var str;
		        var str1;
		        var str11;//�¿���ֵ
		        var ret;
		        if (count<=1)
		        {
		                str=document.form.card_no.value;
		        }
		        else
		        {
		                str ="";
		                for (i=0;i<count-1;i++){
		                        str+=document.form.card_no[i].value+"|";
		                }
		                str+=document.form.card_no[count-1].value;
		        }
		        document.form.card_str.value = str;

		        if (count1<=1)
		        {
		                str1=document.form.card_no1.value;
		                str11=document.form.money1.value;
		        }
		        else
		        {
		                str1 ="";
		                for (i=0;i<count1-1;i++){
		                        str1+=document.form.card_no1[i].value+"|";
		                        str11+=parseFloat(document.form.money1[i].value)+",";
		                }
		                str1+=document.form.card_no1[count1-1].value;
		                str11+=parseFloat(document.form.money1[count1-1].value);
		        }


		        /* 20090325 liyan add */
					var sum_hand_fee = document.form.sum_hand_fee.value;
					if( sum_hand_fee=='')
				    {
				       rdShowMessageDialog("�����Ѳ���Ϊ�գ����������� !");
				       document.form.sum_hand_fee.focus();
				       return false;
				    }
					if(!dataValid( 'b' , sum_hand_fee))
				    {
				       rdShowMessageDialog("���������  "+ sum_hand_fee +" , ��������Ч�������ѣ�");
				       document.form.sum_hand_fee.focus();
				       return false;
				    }
					if ( sum_hand_fee.indexOf(".")!=-1)
					{
						var temp =  sum_hand_fee.substring(sum_hand_fee.indexOf(".")+1,sum_hand_fee.length);
						if ( temp.length > 2 )
						{
							rdShowMessageDialog("������С�����ֻ������2λ��");
							document.form.sum_hand_fee.focus();
							return false;
						}
					}

				    if(parseFloat(sum_hand_fee) < 0)
				  	{
						rdShowMessageDialog(" �����Ѳ���Ϊ������");
				        document.form.sum_hand_fee.focus();
				        return false;
				  	}

					/* 20090325 liyan end */

		        document.form.card_str1.value = str1;
		        document.form.money_str1.value = str11;
		        form.action="s3075_2.jsp";


		         ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");

		     if((ret=="confirm"))
		      {
		        if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
		        {
		                    form.submit();
		        }


		            if(ret=="remark")
		            {
		         if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
		         {
		                    form.submit();
		         }
		           }
		         }
		    else
		    {
		       if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
		       {
		                    form.submit();
		       }
		    }
		    return true;
		}


		 function showPrtDlg(printType,DlgMessage,submitCfm)
		  {  //��ʾ��ӡ�Ի���
			var pType="print";                     // ��ӡ����print ��ӡ subprint �ϲ���ӡ
		    var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
			var sysAccept ="<%=sysAccept%>";                       // ��ˮ��
			var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
			var mode_code=null;                        //�ʷѴ���
			var fav_code=null;                         //�ط�����
			var area_code=null;                    //С������
			var opCode =   "<%=opCode%>";                         //��������
			var phoneNo = "";                           //�ͻ��绰

		   	var h=150;
		   	var w=350;
		   	var t=screen.availHeight/2-h/2;
		   	var l=screen.availWidth/2-w/2;

		   	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
			var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
			var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
			var ret=window.showModalDialog(path,printStr,prop);
		  }

		  function printInfo(printType)
		  {
			    var count=parseInt(form.lines.value);
			    var count1=parseInt(form.lines1.value);


		        //add by anln
		        var cust_info=""; //�ͻ���Ϣ
		      	var opr_info=""; //������Ϣ
		      	var retInfo = "";  //��ӡ����
		      	var note_info1=""; //��ע1
		      	var note_info2=""; //��ע2
		      	var note_info3=""; //��ע3
		      	var note_info4=""; //��ע4

				cust_info+=" "+"|";

				opr_info+="�ɿ����ţ�"+"|";
		        if (count<=1)
		        {
		                    opr_info+=document.form.card_no.value+"|";
		        }
		        else
		        {
		                for (i=0;i<=count-1;i++){
		                opr_info+=document.form.card_no[i].value+"|";
		                }
		        }
		    	opr_info+="�¿����ţ�"+"|";
		        if (count1<=1)
		        {
		                    opr_info+=document.form.card_no1.value+"|";
		        }
		        else
		        {
		                for (i=0;i<=count1-1;i++){
		                opr_info+=document.form.card_no1[i].value+"|";
		                }
		        }

	 			note_info1+=""+"|";

				retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  	      	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ

	    	    return retInfo;
		  }

		function isKeyNumberdot(ifdot)
		{
		    var s_keycode=(navigator.appname=="Netscape")?event.which:event.keyCode;
		        if(ifdot==0)
		                if(s_keycode>=48 && s_keycode<=57)
		                        return true;
		                else
		                        return false;
		    else
		    {
		                if((s_keycode>=48 && s_keycode<=57) || s_keycode==46)
		                {
		                      return true;
		                }
		                else if(s_keycode==45)
		                {
		                    rdShowMessageDialog('���������븺ֵ,����������!');
		                    return false;
		                }
		                else
		                          return false;
		    }
		}


		function compsum()
		{
		        var count=parseInt(form.lines.value);
		        var count1=parseInt(form.lines1.value);
		        var i=0;
		        var countmoney=0;
		        var hand_fee = count*0;
		        var newmoney=0;
		        if(count<=1)
		        {
		                countmoney+=parseFloat(form.money.value);
		        }
		        else
		        {
		                for (i=0;i<count;i++){
		                        countmoney+=parseFloat(form.money[i].value);
		                }
		        }

		        if(count1<=1)
		        {
		                newmoney+=parseFloat(form.money1.value);
		        }
		        else
		        {
		                for (i=0;i<count1;i++){
		                        newmoney+=parseFloat(form.money1[i].value);
		                }
		        }

		        if (countmoney==newmoney){
		                form.infilling_number.value=count;
		                form.infilling_price.value=countmoney;
		                form.sum_hand_fee.value=hand_fee;
		                form.sure.disabled=false;
		                return true;
		        }else if (countmoney>newmoney){
		                rdShowMessageDialog("�����ܽ������¿�����˲飡");
		                return false;
		        }else if (countmoney<newmoney){
		                rdShowMessageDialog("�����ܽ��С���¿�����˲飡");
		                return false;
		        }
		}


		function dotest(a){
		        var h=480;
		        var w=650;
		        var str;
		        var aa=parseInt(a.parentElement.parentElement.parentElement.rowIndex)-2;
		        var bb=parseInt(form.lines.value);

		        if(parseInt(bb) > 1)
		        {
		                if(document.form.card_no[aa].value.length<1){
		                        rdShowMessageDialog("�����뻵�����ţ�",0);
		                        document.form.card_no[aa].focus();
		                        return false;
		                }
		        }
		        else
		        {
		                if(document.form.card_no.value.length<1){
		                        rdShowMessageDialog("�����뻵�����ţ�",0);
		                        document.form.card_no.focus();
		                        return false;
		                }
		        }

		        var t=screen.availHeight/2-h/2;
		        var l=screen.availWidth/2-w/2;
		        var prop="dialogHeight:"+300+"px; dialogWidth:"+500+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";

		        if(parseInt(bb) > 1)
		                str=window.showModalDialog('getprice2.jsp?card_no='+document.form.card_no[aa].value+"&cardflag=0","",prop);
		        else
		                str=window.showModalDialog('getprice2.jsp?card_no='+document.form.card_no.value+"&cardflag=0","",prop);
		        var tmp=str.substring(0,1);
		        if( typeof(str) != "undefined" ){
		                if (parseInt(tmp)==1){
		                                rdShowMessageDialog(str.substring(1,str.length-1),0);
		                                document.location.replace("s3075.jsp");
		                }else{
		                        if (parseInt(bb) >1){
		                                document.form.money[aa].value = str.substring(1,str.indexOf("||"));
		                                document.form.stop_time[aa].value = str.substring(str.indexOf("||")+2);
		                        }else {
		                                document.form.money.value = str.substring(1,str.indexOf("||"));
		                                document.form.stop_time.value = str.substring(str.indexOf("||")+2);
		                        }
		                }
		        }
		}
		function dotest1(a){
		        var h=480;
		        var w=650;
		        var str;
		        var aa=parseInt(a.parentElement.parentElement.parentElement.rowIndex)-2;
		        var bb=parseInt(form.lines1.value);

		        if(parseInt(bb) > 1)
		        {
		                if(document.form.card_no1[aa].value.length<1){
		                        rdShowMessageDialog("�����뻵�����ţ�",0);
		                        document.form.card_no1[aa].focus();
		                        return false;
		                }
		        }
		        else
		        {
		                if(document.form.card_no1.value.length<1){
		                        rdShowMessageDialog("�����뻵�����ţ�",0);
		                        document.form.card_no1.focus();
		                        return false;
		                }
		        }


		        var t=screen.availHeight/2-h/2;
		        var l=screen.availWidth/2-w/2;
		        var prop="dialogHeight:"+300+"px; dialogWidth:"+500+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";

		        if(parseInt(bb) > 1)
		                str=window.showModalDialog('getprice2.jsp?card_no='+document.form.card_no1[aa].value+"&cardflag=1","",prop);
		        else
		                str=window.showModalDialog('getprice2.jsp?card_no='+document.form.card_no1.value+"&cardflag=1","",prop);
		        var tmp=str.substring(0,1);
		        if( typeof(str) != "undefined" ){
		                if (parseInt(tmp)==1){
		                        rdShowMessageDialog(str.substring(1,str.length-1),0);
		                        document.location.replace("s3075.jsp");
		                }else{
		                        if (parseInt(bb) >1){
		                                document.form.money1[aa].value = str.substring(1,str.indexOf("||"));
		                                document.form.stop_time1[aa].value = str.substring(str.indexOf("||")+2);
		                                }else {
		                                document.form.money1.value = str.substring(1,str.indexOf("||"));
		                                document.form.stop_time1.value = str.substring(str.indexOf("||")+2);
		                        }
		                }
		        }
		}

		function dynDelRow(){
		        var bb=parseInt(form.lines.value);
		        if( bb<=1)
		        {
		                rdShowMessageDialog("���һ�в���ɾ������");
		                return false;
		        }
		        else {
		                dyntb.deleteRow();
		                document.form.inp.disabled=false;
		                document.form.lines.value=bb-1;
		        }
		}

		function dynAddRow(){
		        form.lines.value=parseInt(form.lines.value)+1;
		        var tr1=dyntb.insertRow();
		    tr1.id="tr";

		//  sunzx 20070514 ����
		//    tr1.insertCell().innerHTML = '<td ><div align=center><input type=button name=del_line size=4 value=�� onClick="dynDelRow()"></div></td>';
		    tr1.insertCell().innerHTML = '<td ><div align=center><input type=text name=card_no size=20   onKeyPress="return isKeyNumberdot(1)"></div></td>';
		    tr1.insertCell().innerHTML = '<td><div align=center><input type=button name=test class=b_text value=��֤ onClick="dotest(this)"></div></td>';
		    tr1.insertCell().innerHTML = '<td><div align=center><input type=text readonly class=InputGrey name=money size=20  maxlength=20></div></td>';
		    tr1.insertCell().innerHTML = '<td><div align=center><input type=text readonly class=InputGrey name=stop_time size=20  maxlength=20></div></td><td>';            //document.form.inp.disabled=true;
		}

		function dynAddRow1(){

		        form.lines1.value=parseInt(form.lines1.value)+1;
		        var tr2=dyntb1.insertRow();
		    tr2.id="tr";

		//    sunzx 20070514 ����
		//    tr2.insertCell().innerHTML = '<td  width="6%"  ><div align=center><input type=button name=del_line1 size=4 value=�� ></div></td>';
		    tr2.insertCell().innerHTML = '<td width="30%" ><div align=center><input type="text" name="card_no1" maxlength="20"  onkeydown="if(event.keyCode==13)document.form.passwd.focus()" onKeyPress="return isKeyNumberdot(0)"></div></td>';
		    tr2.insertCell().innerHTML = '<td width="19%" ><div align=center><input  name="test1" type=button class=b_text value=��֤ onClick="dotest1(this);"></div></td>';
		    tr2.insertCell().innerHTML = '<td  width="19%" ><div align=center><input type=text readonly class=InputGrey name="money1" size=20  maxlength=20></div></td>';
		    tr2.insertCell().innerHTML = '<td  width="26%" ><div align=center><input type=text readonly class=InputGrey name="stop_time1" size=20  maxlength=20></div></td>';             //document.form.inp.disabled=true;
		}


		function form_load1()
		{
		        form.sure.disabled=true;
		        dynAddRow();
		        dynAddRow1();
		}

		function doclear()
		{
		        document.location.replace("s3075.jsp");
		}
		// -->
	</script>
</HEAD>
<BODY onLoad="form_load1()">
	<FORM action="s3075_2.jsp" method=post name="form">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">������Ϣ</div>
	</div>
	<input type="hidden" name="lines" value="0">
	<input type="hidden" name="lines1" value="0">
	<INPUT TYPE="hidden" name="card_str" value="">
	<INPUT TYPE="hidden" name="card_str1" value="">
	<INPUT TYPE="hidden" name="money_str1" value="">
	<input type="hidden" name="billdate" value="<%=dateStr%>">
	<input type="hidden" name="op_code" value="<%=opcd%>">
	<input type="hidden" name="org_code" value="<%=orgcode%>">
	<input type="hidden" name="optype" value="1">
	<input type="hidden" name="sysAccept" value="<%=sysAccept%>"> <!--liyan add 20090325 -->
        <table id=tbs9 cellspacing="0">
        </table>
        <table id="dyntb"  cellspacing="0">
              <tr align="center">
                <td width="30%" class="blue">
                  ������
                </td>
                <td  width="19%" class="blue">
                  ��֤
                </td>
                <td width="19%" class="blue">
                  ��ֵ
                </td>
                <td  width="26%" class="blue">
                  ��Ч��
                </td>
              </tr>
            </table>
            <table id="dyntb1"  cellspacing="0" >
               <tr align="center">
                <td  width="30%" class="blue">
                  �¿�����
                </td>
                <td  width="19%"  class="blue">
                  ��֤
                </td>
                <td width="19%" class="blue" >
                  ��ֵ
                </td>
                <td  width="26%"  class="blue">
                  ��Ч��
                </td>
              </tr>
            </table>
            <br>
            <div class="title">
		<div id="title_zi">ҵ����Ϣ</div>
	    </div>
            <table cellspacing="0">
                <tr>
                  <td width="36%" class="blue"> ����������</td>
                  <td>
                     <input type="text" readonly name="infilling_number" size="14" class=InputGrey >
                  </td>
                  <td width="38%" class="blue"> ��������ֵ </td>
                  <td>
                      <input type="text" readonly name="infilling_price" size="14" class=InputGrey>
                  </td>
                  <td width="26%" class="blue"> ������</td>
                  <td>
                      <input type="text" name="sum_hand_fee" size="14" >
                  </td>
                </tr>
              </table>
             <table cellspacing="0">
              	<tbody>
              		<tr>
                		<td id="footer">
                  			<input  name="comp" class="b_foot" type=button value=���� onclick="if(compsum());">
                                  	&nbsp;
                                  	<input  name="clear" class="b_foot" type=reset value=��� onclick="doclear()">
                                  	&nbsp;
                  			<input  name="sure" class="b_foot" type=button value=ȷ��  onclick="doCommit();">
                  			&nbsp;
                                  	<input  name="reset" class="b_foot" type=button value=���� onClick="removeCurrentTab()">
                                  	&nbsp;
                		</td>
              		</tr>
              </tbody>
            </table>
	     <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>

