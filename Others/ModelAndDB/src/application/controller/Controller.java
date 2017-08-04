package application.controller;

import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.TextArea;
import javafx.scene.control.TextField;
import javafx.stage.DirectoryChooser;
import javafx.stage.FileChooser;
import javafx.stage.Stage;
import application.settings.Config;

import java.io.*;
import java.net.URL;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Controller {
    // 文件的绝对路径
    private String filePath;
    // 文件夹的局对路径
    private String dirPath;

    @FXML
    Button Submit;

    @FXML
    Button Reset;

    @FXML
    TextArea DB;

    @FXML
    TextArea Logger;

    @FXML
    TextArea Console;
    @FXML
    Button fileChooser;

    @FXML
    Button dirChooser;

    @FXML
    Stage stage;

    @FXML
    TextField model;

    @FXML
    TextField table;

    @FXML
    TextField annotation;

    @FXML
    TextField info;

    @FXML
    Button contrast;

    @FXML
    public void dirSelector() {
        DirectoryChooser directoryChooser = new DirectoryChooser();
        directoryChooser.setTitle("选择文件夹");
        File file = directoryChooser.showDialog(stage);
        if (file != null) {
            dirPath = file.getAbsolutePath();
        }
    }

    @FXML
    public void fileSelector() {
        FileChooser fileChooser = new FileChooser();
        fileChooser.setTitle("选择文件");
        File file = fileChooser.showOpenDialog(stage);
        if (file != null) {
            filePath = file.getAbsolutePath();
        }
    }

    /**
     * 点击提交按钮进行调用相应的程序进行处理
     */
    @FXML
    public void onButtonClick() {
        Console.setText("查询结果：\n");
        // 调用查询模型与数据库的表对应的函数
        if (!DB.getText().isEmpty()) {
            main();
        } else {
            Console.setText("请填加数据库表列表或文件");
        }
    }

    @FXML
    public void onClickContrast() {
        String[] context_B = DB.getText().split("\n");
        String[] context_A = Logger.getText().split("\n");
        if (context_A != null && context_B != null) {
            contrast(context_A,context_B);
        }
    }

    @FXML
    public void onResetClick() {
        Console.setText("");
        Logger.setText("");
        DB.setText("");
        table.setText("");
        model.setText("");
        info.setText("");
        annotation.setText("");
    }


    public HashMap<String, Integer> username = new HashMap<>();

    public void main() {
        HashMap<String, Object> map = ModelTableNum();
        URL url = null;
        HashSet<String> set = (HashSet<String>) map.get("set");
        ArrayList<String> list = (ArrayList<String>) map.get("list");
        Collections.sort(list);
        model.setText(set.size() + "");
        Console.appendText("包含重复的表的个数：" + list.size() + "\n");
        if (list.size() == set.size()) {
            Console.appendText("模型中没有重复的表！\n");
        }
        Console.appendText("检测数据库中的表是否在模型中\n");
        Console.appendText("========================================================\n");
        // 把读取回来的信息转化装换成字符串数组
        String[] context = DB.getText().split("\n");
        table.setText(context.length + "");
        Set<String> set_tmp = dbLoggerndModelCmp(context, set);
        Console.appendText("检查模型中有而数据库中没有的表\n");
        Console.appendText("========================================================\n");
        Set<String> set_Ann = readAnnotation();
        annotation.setText(set_Ann.size() + "");
        for (String i : list) {
            if (!set_tmp.contains(i.trim())) {
                if (!set_Ann.contains(i.trim()) && set.contains(i.trim())) {
                    Console.appendText(i + "\n");
                }
            }
        }
        annotationMattern(set.size(), context.length, set_Ann.size());
        Console.appendText("========================================================\n");
        Console.appendText("注释的表有：\n");
        Console.appendText("========================================================\n");
        for (String i : set_Ann) {
            Console.appendText(i + "\n");
        }
        Console.appendText("========================================================\n");
        Console.appendText("模型中的属组名包括：" + username + "\n");
    }

    /**
     * 用于计算和记录账管模型中的表的数量
     *
     * @return
     */
    public HashMap<String, Object> ModelTableNum() {
        String root = null;
        if (dirPath == null) {
            root = "D:\\tmp";
        } else {
            root = dirPath;
        }
        Set<String> model_set = getModelFiles(root);
        Logger.appendText(dirPath + "\n");
        Path path = Paths.get(root);
        File file = path.toFile();
        File[] files = file.listFiles();
        HashSet<String> set = new HashSet<>();
        ArrayList<String> list = new ArrayList<>();
        HashMap<String, Object> map = new HashMap<>();
        username.clear();
        for (File i : files) {
            if (model_set.contains(i.getName())) {
                String file_path = root + File.separator + i.getName().toString();
                File tmp_file = new File(file_path);
                try {
                    BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(tmp_file)));
                    String context = null;
                    // 循环遍历tmp下的*.sql文件内容
                    int count = 0;
                    while ((context = br.readLine()) != null) {
                        String regex = "CREATE(.*)TABLE (.*)\\.(.*)[(|\n|  (| (]*";
                        Pattern pattern = Pattern.compile(regex);
                        Matcher matcher = pattern.matcher(context.toUpperCase());
                        if (matcher.find()) {
                            count++;
                            String user = matcher.group(2);
                            if (username.containsKey(user)) {
                                int num = username.get(user);
                                num++;
                                username.put(user, num);
                            } else {
                                username.put(user, 1);
                            }
                            String tmp_str = matcher.group(3);
                            //Console.appendText(tmp_str);
                            set.add(tmp_str.trim());
                            list.add(tmp_str.trim());
                        }
                    }
                    Logger.appendText(i.getName() + "的表数量是" + count + "\n");
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        map.put("set", set);
        map.put("list", list);
        return map;
    }

    /**
     * 模型的目录文件名列表，要进行比较的模型文件
     *
     * @param dirPath
     * @return
     */
    private Set getModelFiles(String dirPath) {
        HashSet<String> set = new HashSet<>();
        InputStream inputStream = Controller.class.getResourceAsStream(Config.FILES);
        try {
            BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream));
            String buffer = null;
            while ((buffer = reader.readLine()) != null) {
                set.add(buffer);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return set;
    }

    /**
     * 用于比较数据库和账管模型的表数量
     *
     * @param db_file 数据库中的表名称的文件名
     * @return 返回生产库中的表
     */
    public HashSet<String> dbLoggerndModelCmp(String[] db_file, HashSet<String> set) {
        ArrayList<String> list = new ArrayList<>();
        HashSet<String> set_tmp = new HashSet<>();
        try {
            if (db_file.length == 0) {
                Console.appendText("请添加数据库的表表名");
            }
            for (String buffer : db_file) {
                list.add(buffer.trim());
                set_tmp.add(buffer.trim());
            }
            int count = 0;
            Console.appendText("========================================================\n");
            Console.appendText("DB库中有但是模型中没有的表是：\n");
            Console.appendText("========================================================\n");
            for (String i : list) {
                if (!set.contains(i)) {
                    count++;
                    Console.appendText(i + "\n");
                }
            }
            Console.appendText("========================================================\n");
            Console.appendText("一共有" + count + "个表不存在\n");
            Console.appendText("========================================================\n");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return set_tmp;
    }

    /**
     * 用于读取注释掉的表名
     *
     * @return
     */
    private Set<String> readAnnotation() {
        Set<String> set = new HashSet<>();
        InputStream inputStream = Controller.class.getResourceAsStream(Config.ANNOTATION);
        try {
            BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream));
            String buffer = null;
            while ((buffer = reader.readLine()) != null) {
                set.add(buffer);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return set;
    }


    /**
     * 用于测试表模型与数据库的表的数量比对
     */
    private void annotationMattern(int model, int table, int annotation) {
        if (model - annotation - username.get("DBBILLPRG") == table) {
            info.setText("数据库中的表的数量正常：" + table + "个");
        } else {
            info.setText("数据库中的表的数量不正常，请看日志");
        }
    }

    /**
     * 实现A库与B库的对比
     */
    private void contrast(String[] A, String[] B) {
        HashSet<String> set = new HashSet<>();
        for (String i : A) {
            set.add(i);
        }
        for (String i : B) {
            if (set.contains(i)) {
                set.remove(i);
            }
        }
        Console.appendText("B中有的表而A中没有的表：\n");
        Console.appendText("========================================================\n");
        for (String i : set) {
            Console.appendText(i+"\n");
        }
        Console.appendText("========================================================\n");
        Console.appendText("一共缺少" + set.size() + "个表\n");
        Console.appendText("========================================================\n");
        set.clear();
        for (String i : B) {
            set.add(i);
        }
        for (String i : A) {
            if (set.contains(i)) {
                set.remove(i);
            }
        }
        Console.appendText("A中有的表而B中没有的表：\n");
        Console.appendText("========================================================\n");
        for (String i : set) {
            Console.appendText(i+"\n");
        }
        Console.appendText("========================================================\n");
        Console.appendText("一共缺少" + set.size() + "个表\n");
    }

}
