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
  InputStream in = null;
        try {
        in = new BufferedInputStream(new FileInputStream(paths));
         props.load(in);
         String addw = props.getProperty(key);
         if(addw!=null && !"".equals(addw)){
         	returnValues =new String(props.getProperty(key).getBytes("ISO-8859-1")); 
         }else{
         	returnValues = "";
         }
          System.out.println("gaopengSeeGetRD================1111111");  
            return returnValues;
        } catch (FileNotFoundException ex) {
         ex.printStackTrace();
         System.out.println("gaopengSeeGetRD================222222");  
         return "";
         
        }catch (Exception e) {
         e.printStackTrace();
         System.out.println("gaopengSeeGetRD================33333333333");  
         return "";
         
        }finally{
					try{
						in.close();
					}catch(Exception e){
						e.printStackTrace();
						System.out.println("gaopengSeeGetRD================444444444444");  
					}
				}
        
 }
 	public List readValues(String filePath){
		/*根据URL获取properties文件中所有配置信息*/
		Properties props = new Properties();
		List resultList = new ArrayList();
		InputStream in = null;
		try {
			in = new BufferedInputStream (new FileInputStream(filePath));
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
		}finally{
					try{
						in.close();
					}catch(Exception e){
						e.printStackTrace();
					}
				}
		return resultList;
	}
%>