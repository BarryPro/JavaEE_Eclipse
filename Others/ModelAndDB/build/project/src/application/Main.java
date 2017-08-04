package application;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.image.Image;
import javafx.stage.Stage;
import application.settings.Config;

/**
 * @author belong
 * @description JavaFX 的程序的入口
 */
public class Main extends Application {

    @Override
    public void start(Stage primaryStage) throws Exception {
        // 加载资源文件的界面配置文件
        Parent root = FXMLLoader.load(getClass().getResource(Config.REC));
        // 设置标题
        primaryStage.setTitle(Config.TITLE);
        // 设置界面的大小
        primaryStage.setScene(new Scene(root, 734, 430));
        // 设置窗口的图标(图标不识别*.ico格式)
        primaryStage.getIcons().add(new Image(Config.ICON));
        // 显示界面
        primaryStage.show();
    }

    /**
     * @param args the input arguments
     */
    public static void main(String[] args) {
        launch(args);
    }
}
