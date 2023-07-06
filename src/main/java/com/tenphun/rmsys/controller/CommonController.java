package com.tenphun.rmsys.controller;

import com.tenphun.rmsys.common.BusinessException;
import com.tenphun.rmsys.common.R;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.util.UUID;

@RestController
@RequestMapping("/common")
public class CommonController {
    @Value("${rms.path}")
    private String basePath;

    /**
     * Upload File
     */
    @PostMapping("/upload")
    public R<String> upload(MultipartFile file){
        // get file type suffix
        String originalFilename = file.getOriginalFilename();
        String suffix = originalFilename.substring(originalFilename.lastIndexOf("."));

        // Use UUID to generate a new name
        String fileName = UUID.randomUUID().toString() + suffix;

        // create a File and create if it doesn't exist
        File dir = new File(basePath);
        if(!dir.exists()){
            dir.mkdirs();
        }

        // write into directory
        try {
            file.transferTo(new File(basePath+fileName));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return R.success(fileName);
    }

    @GetMapping("/download")
    public void download(String name, HttpServletResponse response){
        try {
            // input steam, read file content
            FileInputStream input = new FileInputStream(new File(basePath, name));
            // output stream, write back to frontend
            ServletOutputStream output = response.getOutputStream();
            response.setContentType("image/jpeg");
            int len = 0;
            byte[] bytes = new byte[1024];
            while((len = input.read(bytes)) != -1){
                output.write(bytes, 0, len);
                output.flush();
            }
            input.close();
            output.close();
        } catch (Exception e) {
            throw new BusinessException("Failed to present the image");
        }
    }
}
