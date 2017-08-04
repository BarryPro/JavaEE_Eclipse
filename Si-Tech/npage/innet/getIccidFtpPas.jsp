<%!
		String getIccidFtpPas(String orderPasPropPath){
		java.util.Properties propertie = new java.util.Properties();		
		String retPas = "";
		try {
			 java.io.FileInputStream inputFile = new  java.io.FileInputStream(orderPasPropPath);
			 
			propertie.load(inputFile);
			retPas = (String) propertie.get("ftpPassword");
		    inputFile.close();      
		} catch (java.io.FileNotFoundException ex) {      
		    System.out.println("文件不存在");      
		    ex.printStackTrace();      
		} catch (java.io.IOException ex) {      
		    System.out.println("装载文件失败");      
		    ex.printStackTrace();      
		}
		return retPas;
	}
%>