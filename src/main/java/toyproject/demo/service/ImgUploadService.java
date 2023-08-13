package toyproject.demo.service;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import toyproject.demo.domain.User;

import java.io.File;
import java.io.IOException;

@Service
public class ImgUploadService {
    public String ProfileImgUpload(MultipartFile file, String userId) throws IOException {
        String filePath = userId+"/profile/"+file.getOriginalFilename();
        File directory = new File(filePath).getParentFile();
        if (!directory.exists()) {
            directory.mkdirs();
        }
        file.transferTo(new File(filePath));

        return filePath;
    }

    public String PostImgUpload(MultipartFile file, String userId) throws IOException {
        String baseUploadPath = "/Users/gimmin-ung/ImageServer";; // 절대 경로 설정
        String filePath = baseUploadPath + "/" + userId + "/post/" + file.getOriginalFilename();
        File directory = new File(filePath).getParentFile();
        if (!directory.exists()) {
            directory.mkdirs();
        }
        file.transferTo(new File(filePath));
        return filePath;
    }
}
