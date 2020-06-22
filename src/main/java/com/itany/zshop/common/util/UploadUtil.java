package com.itany.zshop.common.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

public class UploadUtil {

    public static String renameFile(String fileName) {
        return new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) +
                new Random().nextInt(100) +
                fileName.substring(fileName.lastIndexOf("."));
    }

}
