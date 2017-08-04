<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ page import="com.sitech.boss.amd.viewbean.*"%>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue"%>
<%@ page import="com.sitech.boss.pub.exception.BOException"%>
<%!
/**********得到打印流水***************/
  public String getMaxAccept()
  {
    comImpl coTemp=new comImpl();
    //打印流水
    String sqlMaxAcceptTemp = ""; 
	ArrayList maxAcceptArrTemp = new ArrayList();
    String[][] maxAcceptStrTemp = new String[][]{} ;
	String maxAcceptTemp = "-1";
	try
	{
        ScallSvrViewBean viewBean = new ScallSvrViewBean();
            CallRemoteResultValue callRemoteResultValue = null;
            String[] inParas = new String[]{""};
        sqlMaxAcceptTemp = "select  sMaxSysAccept.nextval from dual";
            inParas[0]=sqlMaxAcceptTemp;
       // maxAcceptArrTemp = coTemp.spubqry32("1",sqlMaxAcceptTemp);
       
       callRemoteResultValue = viewBean.callService("0", null, "TlsPubSelBoss", "1", inParas);
            maxAcceptStrTemp = callRemoteResultValue.getData();
       // System.out.println("maxAcceptArrTemp=="+maxAcceptArrTemp.size());
        //maxAcceptStrTemp = (String[][])maxAcceptArrTemp.get(0);
        System.out.println("maxAcceptArrTemp.length=="+maxAcceptStrTemp.length);
		    maxAcceptTemp = maxAcceptStrTemp[0][0];
		    System.out.println("maxAcceptArrTemp==2");
		   return maxAcceptTemp;
    }catch(Exception e)
	{
	    System.out.println("getMaxAccept: 得到打印流水错误!");
        e.printStackTrace();
		return  "-1";
	}
  }
/**********得到生效执行时间***************/
  public String getExeDate(String flag,String opCode)
  {
      String exeDateStr = "";
	  String sqlStr="";

	  if(flag.equals("0"))
	  {
		  if(opCode.equals("1255") || opCode.equals("1258"))
		  {
		    sqlStr = "select to_char(sysdate+1,'yyyymmdd')||' 0001' from dual";
		  }else
		  {
		    sqlStr = "select to_char(sysdate,'yyyymmdd hh24mi') from dual";
		  }
	  }else if(flag.equals("1"))//预约生效
	  {
		  if(opCode.equals("1258"))
		  {
		    sqlStr = "select to_char(sysdate+1,'yyyymmdd')||' 0001' from dual";
		  }else if(opCode.equals("3530")){
			sqlStr = "select  to_char(add_months(sysdate,12),'yyyymmdd') from dual";
		  }else if(opCode.equals("1141")){
			sqlStr = "select  to_char(add_months(sysdate,11),'yyyymm') from dual";
		  }else{
		    sqlStr = "select  to_char(add_months(sysdate,1),'yyyymm')||'01 0001' from dual";
		  }		  
	  }
	 // comImpl co=new comImpl();
	//  ArrayList exeDateArr  = co.spubqry32("1",sqlStr);
	 // exeDateStr  = ((String[][])exeDateArr.get(0))[0][0];
     try{      
            ScallSvrViewBean viewBean = new ScallSvrViewBean();
            CallRemoteResultValue callRemoteResultValue = null;
            String[] inParas = new String[]{""};
            inParas[0]=sqlStr;
            callRemoteResultValue = viewBean.callService("0", null, "TlsPubSelBoss", "1", inParas);
            exeDateStr = ((String[][])callRemoteResultValue.getData())[0][0];
         }   
    catch(Exception e){
       		//System.out.println("Call queryView Failed!");
     	}          
	  return exeDateStr;
  }
%>