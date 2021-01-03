package service.tools;

import java.io.*;

public class FileOption {
    public static void writeToFile(String path, String content){
        try {
            FileOutputStream fos = new FileOutputStream(new File(path));
            fos.write(content.getBytes());
            if(null != fos){
                fos.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static String readFromFile(String path){
        String content = "";
        try {
            FileInputStream fis = new FileInputStream(new File(path));
            byte[] bytes = new byte[fis.available()];
            fis.read(bytes);
            content = new String(bytes);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return content;
    }

    public static void deleteBlog(int blogId){
        File markdownFile = new File("C:/Users/YLove/Desktop/课设博客/ppy.blogs/web/user_blogs/blogs_htmlcode/" + blogId + ".txt");
        markdownFile.delete();
        File htmlCodeFile = new File("C:/Users/YLove/Desktop/课设博客/ppy.blogs/web/user_blogs/blogs_markdown/" + blogId + ".txt");
        htmlCodeFile.delete();
    }
}
