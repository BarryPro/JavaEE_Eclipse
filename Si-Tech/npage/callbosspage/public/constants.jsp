<%
  /*
   * 功能: 将权限ID写成常量
　 * 版本: 1.0
　 * 日期: 2009/7/15
　 * 作者: pengtw
　 * 版权: sitech
   * modify by yinzx 20091010 
 　*/
 %>

<%!
  /*
   *投产的时候将测试环境配置关闭，将正式环境配置打开。
   */
   

  
  //吉林环境
  //public static String FUHEYUAN_ID = "019D0E";         //复核员
  //public static String ZHIJIANZUZHANG_ID = "019D0G";   //质检组长 
  //public static String TOUSU_ID = "019D01";            //投诉
  //public static String ZHIJIANYUAN_ID = "019D0B";      //质检员
  //public static String HUAWUYUAN_ID = "019D07";        //普通坐席
  //public static String ZBJL_ID = "011029";             //值班经理
  //public static String XZZ_ID = "011023";              //小组长
  
  //tancf 20100603 修改角色权限 测试环境 
  public static String FUHEYUAN_ID = "019D0E";                                                               //复核员 
  public static String TOUSU_ID = "019D01";                                                                  //投诉
  public static String XZZ_ID = "011023";                                                                    //小组长
  public static  String[] ZHIJIANZUZHANG_ID=new String[]{"019D0G","019D0H"};                                 //质检组长
  public static  String[] ZHIJIANYUAN_ID=new String[]{"019D0B","019D0C","019D0D","019D0E","019D0F"};         //质检员
  public static  String[] HUAWUYUAN_ID=new String[]{"019D06","019D07","019D08","019D09","019D0A","019D0T"};  //普通坐席
  public static  String[] ZBJL_ID=new String[]{"019D01","019D02","019D03","019D04","019D05"};                //值班经理或班长
%>