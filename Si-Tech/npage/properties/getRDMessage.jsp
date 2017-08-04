<%@ page import="java.io.FileInputStream"%> 
<%@ page import="java.util.Properties"%> 
<%@ page import="java.io.IOException"%>
<%@ page import="java.io.FileOutputStream"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.OutputStream"%>
<%@ page import="java.io.BufferedInputStream"%>



<%!
 public String readValue(String param1,String param2,String param3,String paths) {//根据key值和路径查询properties文件中rdmessage信息
  String returnValues=null;
  Properties props = new Properties();
  String key = param1+"."+param2+"."+param3;
        try {
        System.out.println(paths+"------wanghyd");
        InputStream in = new BufferedInputStream(new FileInputStream(paths));
         props.load(in);
          returnValues =new String(props.getProperty(key).getBytes("ISO-8859-1"),"gbk"); 
            System.out.println(key+returnValues+"------wanghyd");
            return returnValues;
        } catch (FileNotFoundException ex) {
         ex.printStackTrace();
         System.out.println("wrong------wanghyd-ssss"+ex);
         return null;
         
        }catch (Exception e) {
         e.printStackTrace();
         System.out.println("wrong------wanghyd"+e);
         return null;
         
        }
        
 }
public List readValues(String filePath){
	/*根据URL获取properties文件中所有配置信息*/
	Properties props = new Properties();
	List resultList = new ArrayList();
	try {
		InputStream in = new BufferedInputStream (new FileInputStream(filePath));
		props.load(in);
		Enumeration en = props.propertyNames();
		while (en.hasMoreElements()) {
			String key = (String) en.nextElement();
			String Property = props.getProperty (key);
			resultList.add(Property);
		}
	} catch (Exception e) {
		e.printStackTrace();
		return null;
	}
	return resultList;
}

/*zhangyan*/
public List readKeyValues(String strKey , String filePath){
	/*根据URL获取properties文件中所有配置信息*/
	Properties props = new Properties();
	List resultList = new ArrayList();
	try {
		InputStream in = new BufferedInputStream (new FileInputStream(filePath));
		props.load(in);
		Enumeration en = props.propertyNames();
		while (en.hasMoreElements()) {
			String key = (String) en.nextElement();
			if ( key.indexOf(strKey)!=-1 )
			{
				String Property = new String(props.getProperty(key).getBytes("ISO-8859-1"),"gbk"); 
				resultList.add(Property);
			}
		}
	} catch (Exception e) {
		e.printStackTrace();
		return null;
	}
	return resultList;
}
	
	
 /*
  public String readValue(String param1,String param2,String param3) {//根据key值查询properties文件中rdmessage信息
  String returnValues=null;
  Properties props = new Properties();
  String key = param1+"."+param2+"."+param3;
  //HttpServletRequest request = ServletActionContext.getRequest; 
  //String paths = request.getRealPath("npage/properties")+"/getRDMessage.properties";

        try {
        InputStream in = new BufferedInputStream(new FileInputStream(paths));
         System.out.println(in+"------wanghyd");
         props.load(in);
          returnValues =new String(props.getProperty(key).getBytes("ISO-8859-1"),"gbk"); 
            System.out.println(key+returnValues+"------wanghyd");
            return returnValues;
        } catch (FileNotFoundException ex) {
         ex.printStackTrace();
         System.out.println("wrong------wanghyd-ssss"+ex);
         return null;
         
        }catch (Exception e) {
         e.printStackTrace();
         System.out.println("wrong------wanghyd"+e);
         return null;
         
        }
        
 }*/
%>