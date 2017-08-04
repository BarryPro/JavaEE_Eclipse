<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/se112/public_title_name.jsp"%>
<%@ include file="/npage/se112/footer.jsp"%>
<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="java.util.*"%>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>
<HEAD>
<TITLE>
可选套餐明细
</TITLE>
</HEAD>
<!----------------------------------页头显示区域----------------------------------------->
<body>

<%
//获得服务参数
System.out.println("进来了========================");
String op_code = "e177"; 
String cust_id = request.getParameter("cust_id");                        //客户ID
String maincash_no =request.getParameter("maincash_no");                //主资费代码
String newcash_no =request.getParameter("ip");                          //新主资费代码
if(newcash_no.indexOf(" ")!=-1){
	newcash_no = newcash_no.substring(0,newcash_no.indexOf(" ")); 
}
String belong_code = request.getParameter("belong_code");                //belong_code
String temmode_type =request.getParameter("mode_type");
String mode_type = temmode_type;                                           //mode_type
String sendflag =request.getParameter("sendflag");                      //生效方式
String mode_name = request.getParameter("mode_name");                    //套餐名称
String minopen = request.getParameter("minopen");											  //得到最大，最小开通数
String maxopen = request.getParameter("maxopen");
String login_no=request.getParameter("login_no");								//工号

//String mode_type = temmode_type.substring(0,1);                       //mode_type
String ret_code="";
String ret_msg="";
System.out.println("op_code1111============"+op_code);
System.out.println("login_no============"+login_no);
System.out.println("cust_id============"+cust_id);
System.out.println("maincash_no============"+maincash_no);
System.out.println("newcash_no============"+newcash_no);
System.out.println("belong_code============"+belong_code);
System.out.println("mode_type============"+mode_type);
System.out.println("sendflag============"+sendflag);
System.out.println("mode_name============"+mode_name);
%>    
					<s:service name="s1270Init">
							<s:param name="ROOT">
							<s:param name="LoginAccept" type="string" value="" />                 
					 		<s:param name="ChnSource" type="string" value="01" />                 
					 		<s:param name="OpCode" type="string" value="e177" />                  
					 		<s:param name="LoginNo" type="string" value="<%=login_no %>" />        
					 		<s:param name="LoginPwd" type="string" value="" />                    
					 		<s:param name="PhoneNo" type="string" value="" />                     
					 		<s:param name="UserPwd" type="string" value="" />                     
					 		<s:param name="IdNo" type="string" value="<%=cust_id%>" />           
					 		<s:param name="OldMode" type="string" value="<%=maincash_no%>" />    
					 		<s:param name="NewMode" type="string" value="<%=newcash_no%>" />     
					 		<s:param name="BelongCode" type="string" value="<%=belong_code%>" /> 
					 		<s:param name="ModeType" type="string" value="<%=mode_type %>" />     
					 		<s:param name="SendFlag" type="string" value="<%=sendflag %>" />      
					 		<s:param name="ModeTypeName" type="string" value="<%=mode_name %>" /> 
						</s:param>
				</s:service>                          
		<div class="title">
			<div id="title_zi">可选资费明细</div>
		</div>
      
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
			   <tr style="display:none">
					   <td><input type="checkbox" name="checkId" id="checkId"></td>
		         <td><div align="center"><input type="text" id="Rinput1" value=""></div></td>
					   <td><div align="center"><input type="text" id="Rinput2" value=""></div></td>
					   <td><div align="center"><input type="text" id="Rinput3" value=""></div></td>
					   <td><div align="center"><input type="text" id="Rinput4" value=""></div></td>
					   <td><div align="center"><input type="text" id="Rinput5" value=""></div></td>
					   <td><div align="center"><input type="text" id="Rinput6" value=""></div></td>
					   <td><div align="center">
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
<%
        Map map = new HashMap();
		List feechagel = result.getList("OUT_DATA.BUSI_INFO");
		String[][] data= new String[feechagel.size()][13];
//						  data = result_must_2;
//        String test[][] = result_must_2;
    		 System.out.println("+++++++++++++++++++++++++feechagel.size()++++++++++++++++++"+feechagel.size());
	for(int i =0;i<feechagel.size();i++){
	 	System.out.println("++++++++++++++++++++++++dddddd+++++++++++++");                                                                         
		map = MapBean.isMap(feechagel.get(i));                                                         
		if(map==null){
			data[i][0]="";                                                                                   
			data[i][1]="";                                                                                 
			data[i][2]="";                                                                                 
			data[i][3]="";                                                                                   
			data[i][4]="";                                                                               
			data[i][5]="";                                                                               
			data[i][6]="";                                                                            
			data[i][7]="";                                                                                 
			data[i][8]="";                                                                                   
			data[i][9]="";                                                                                   
			data[i][10]="";                                                                              
			data[i][11]="";
			data[i][12]="";				
		 continue;}                                                                                  
			String ModeName= (String)map.get("ModeName")== null?"":(String)map.get("ModeName");   
			System.out.println("+++++++++++++++++++++++++ModeName++++++++++++++++++"+ModeName);                     
			String ModeStatus= (String)map.get("ModeStatus")== null?"":(String)map.get("ModeStatus");                  
			String TmBegin= (String)map.get("TmBegin")== null?"":(String)map.get("TmBegin");                  
			String TmEnd= (String)map.get("TmEnd")== null?"":(String)map.get("TmEnd");                        
			String ModeTypeName= (String)map.get("ModeTypeName")== null?"":(String)map.get("ModeTypeName");            
			String SendFlagName= (String)map.get("SendFlagName")== null?"":(String)map.get("SendFlagName");            
			String ModeChoicedName= (String)map.get("ModeChoicedName")== null?"":(String)map.get("ModeChoicedName");   
			String ModeCode= (String)map.get("ModeCode")== null?"":(String)map.get("ModeCode");                    
			String ModeType= (String)map.get("ModeType")== null?"":(String)map.get("ModeType");                        
			String SendFlag= (String)map.get("SendFlag")== null?"":(String)map.get("SendFlag");                        
			String OldAccept= (String)map.get("OldAccept")== null?"":(String)map.get("OldAccept");            
			String ModeChoiced= (String)map.get("ModeChoiced")== null?"":(String)map.get("ModeChoiced");    
			String ModeNote= (String)map.get("ModeNote")== null?"":(String)map.get("ModeNote");        
							System.out.println("+++++++++++++++++++++++++ModeStatus++++++++++++++++++"+ModeStatus);
							System.out.println("+++++++++++++++++++++++++TmBegin++++++++++++++++++"+TmBegin);
							System.out.println("+++++++++++++++++++++++++TmEnd++++++++++++++++++"+TmEnd);
							System.out.println("+++++++++++++++++++++++++ModeTypeName++++++++++++++++++"+ModeTypeName);
							System.out.println("+++++++++++++++++++++++++SendFlagName++++++++++++++++++"+SendFlagName);
							System.out.println("+++++++++++++++++++++++++ModeChoicedName++++++++++++++++++"+ModeChoicedName);
							System.out.println("+++++++++++++++++++++++++ModeCode++++++++++++++++++"+ModeCode);
							System.out.println("+++++++++++++++++++++++++ModeType++++++++++++++++++"+ModeType);
							System.out.println("+++++++++++++++++++++++++SendFlag++++++++++++++++++"+SendFlag);
							System.out.println("+++++++++++++++++++++++++OldAccept++++++++++++++++++"+OldAccept);	 
								System.out.println("+++++++++++++++++++++++++ModeChoiced++++++++++++++++++"+ModeChoiced);	 
							System.out.println("+++++++++++++++++++++++++ModeNote++++++++++++++++++"+ModeNote);        				 
			data[i][0]=ModeName;                                                                                   
			data[i][1]=ModeStatus;                                                                                 
			data[i][2]=TmBegin;                                                                                 
			data[i][3]=TmEnd;                                                                                   
			data[i][4]=ModeTypeName;                                                                               
			data[i][5]=SendFlagName;                                                                               
			data[i][6]=ModeChoicedName;                                                                            
			data[i][7]=ModeCode;                                                                                 
			data[i][8]=ModeType;                                                                                   
			data[i][9]=SendFlag;                                                                                   
			data[i][10]=OldAccept;                                                                              
			data[i][11]=ModeChoiced;
			data[i][12]=ModeNote;					                                                                     
	}        
		System.out.println("+++++++++++++++++++++++++************8++++++++++++++++++");        	                                                                                                  
      int kk = 0;
	  if(data.length>0){
	    kk = data[0].length - 2 ;
	  }
	  	String tbclass="";
      for(int y=0;y<data.length;y++){
					if(y%2==0){
	      		tbclass="Grey";
	      	}else{
	      		tbclass="";	
	      	}
	  			String addstr = data[y][0] +"#" +data[y][1]+"#"+y;	  
		  %>
  <tr align="center">
  <%if(data[y][kk].equals("0")){//可改不选中%>
  <td class="<%=tbclass%>"><input type="checkbox" name="checkId"  value="<%=addstr%>"></td>

  <%}if(data[y][kk].equals("c")){//不可改不选中%>
  <td class="<%=tbclass%>"><input type="checkbox" name="checkId"  value="<%=addstr%>" onclick="
	if(document.all.checkId[<%=y%>+1].checked==true){
	document.all.checkId[<%=y%>+1].checked=false;}
	rdShowMessageDialog('因生效方式与结束时间冲突而不能申请!');
	return false;
	"></td>
  <%     }
		 // System.out.println("data[0].length="+data[0].length);
      for(int j=0;j<data[0].length;j++){
    String tbstr="";
    String temp="";
	//System.out.println("data["+y+"]["+j+"]"+data[y][j].trim());
	if(j==1)
	{
	String habitus ="";
	if(data[y][j].trim().equals("Y"))habitus="已开通";
	if(data[y][j].trim().equals("N"))habitus="未开通";
	tbstr = "<td class='"+tbclass+"'>" + habitus + "<input type='hidden' " +
          		            " id='Rinput" + (j+1) + "' name='Rinput" + (j+1) + "'  value='" + 
          		            (data[y][j]).trim() + "'readonly></TD>";
	}
	else if(j>6)
	{
	tbstr = " <input type='hidden' " +
          		            " id='Rinput" + (j+1) + "' name='Rinput" + (j+1) + "'  value='" + 
          		            (data[y][j]).trim() + "'readonly>";
	}
	else
	{
	tbstr = "<td class='"+tbclass+"'>" + data[y][j].trim() + "<input type='hidden' " +
          		            " id='Rinput" + (j+1) + "' name='Rinput" + (j+1) + "'  value='" + 
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
%>
<input type="hidden" name="maxopen" value="<%=maxopen%>">
<input type="hidden" name="minopen" value="<%=minopen%>">
          </TABLE>
          
          
		  <TABLE cellSpacing="0">
          <TBODY>
            <TR> 
              <TD id="footer">
						  <!-------------------------------有记录时------------------------------------>
						  <input class="b_foot" name=sure  type=button value=确认 onclick="if(maxopen()) returndata();">
              <input class="b_foot" name=close  type=button value=关闭 onclick="returnclose()">
					  	<!-------------------------
		              <input name=sure  type=button value=确认 onclick="senddata();">
					 		------无记录时------------------------------------>
              </TD>
            </TR>
          </TBODY>
        </TABLE>
		  <body>
		  </html>
		  
		  
<script language="javascript">
/*----------------------------对页面选中数据进行传输--------------------------------*/
function returnclose(){
   window.returnValue="";
   window.close();

}
function returndata()
{
   
var end = "";
var obj = "";
var thestr = "";
  
for(var i = 1; i<document.all.checkId.length;i++)
	{
		 if(document.all.checkId[i].checked==true)
			{

			 thestr = thestr + document.all.Rinput1[i].value +"|";
			 thestr = thestr + document.all.Rinput2[i].value +"|";
       thestr = thestr + document.all.Rinput3[i].value+"|";
			 thestr = thestr + document.all.Rinput4[i].value+"|";
			 thestr = thestr + document.all.Rinput5[i].value+"|";
			 thestr = thestr + document.all.Rinput6[i].value+"|";
			 thestr = thestr + document.all.Rinput7[i].value+"|";
			 thestr = thestr + document.all.Rinput8[i].value+"|";
			 thestr = thestr + document.all.Rinput9[i].value+"|";
			 thestr = thestr + document.all.Rinput10[i].value+"|";
			 thestr = thestr + document.all.Rinput11[i].value+"|";
			 thestr = thestr + document.all.Rinput12[i].value+"|";
			 if(document.all.Rinput13[i].value==""){
				thestr = thestr +"无描述信息"+"|";
			 }else{
				 thestr = thestr + document.all.Rinput13[i].value+"|";
			 }
			 //rdShowMessageDialog("thestr="+thestr);
			/* for(var t=1;t<13;t++)
				 {
				  obj = "Rinput"+ t;
				  thestr = thestr + document.all[i](obj).value +"|";
				 }
			*/
			 }   
    }
          end = thestr;
//rdShowMessageDialog("end="+end);
   window.returnValue=end;
   window.close();
}
function maxopen()
{
	var flag = 0;
	var maxopen1 = '<%=maxopen%>';
	var minopen1 = '<%=minopen%>';
	for(var z = 1;z<document.all.checkId.length;z++)
	{
		if(document.all.checkId[z].checked==true)
		   {flag++;}
	}
	
  var maxopen = parseInt(maxopen1);
	var minopen = parseInt(minopen1);	
	
	if(flag>maxopen||flag<minopen){//最终的开通数与最大开通数比较
		rdShowMessageDialog("本次开通数为'"+flag+"'应在'"+minopen+"'－'"+maxopen+"'之间！");
	  	return false;
	 	} 
	else{return true;}
}
</script>
