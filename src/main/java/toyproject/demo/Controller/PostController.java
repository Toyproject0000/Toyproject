package toyproject.demo.Controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import toyproject.demo.domain.Post;
import toyproject.demo.domain.User;
import toyproject.demo.service.ImgUploadService;
import toyproject.demo.service.PostService;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/post")
public class PostController {
    /*
    * 글쓰기
    * 글수정
    * 글삭제
    * 내용으로 글검색
    * 유저 글 검색(내 글 검색)
    * 내 글 내용으로 검색
    * 팔로워 글검색(모든 팔로워)
    * 좋아요한 글검색
    * 날짜로 글 검색
    * 특정날짜이후로 쓴 글 검색
    * */
    private final PostService postService;
    private final ImgUploadService imgUploadService;

    public PostController(PostService postService, ImgUploadService imgUploadService) {
        this.postService = postService;
        this.imgUploadService = imgUploadService;
    }

    @PostMapping("/submit")
    public String submitPost(@RequestParam("file") MultipartFile file, @RequestParam("data") String jsonData){
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            Post post = objectMapper.readValue(jsonData, Post.class);
            String imgLocation = imgUploadService.PostImgUpload(file, post.getUserId());
            post.setImgLocation(imgLocation);

            postService.submit(post);

            return "ok";
        }catch (Exception e){
            return "에러 발생";
        }
    }

    @PostMapping("/read/img")
    public ResponseEntity<byte[]> readImg(@RequestBody Post post) throws IOException {
        String imgLocation = postService.findPost(post).get(0).getImgLocation();

        Path imagePath = Paths.get(imgLocation);
        byte[] imageBytes = Files.readAllBytes(imagePath);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.IMAGE_JPEG); // 이미지 타입에 맞게 설정

        return ResponseEntity.ok()
                .headers(headers)
                .body(imageBytes);
    }
    @PostMapping("/read")
    public String read(@RequestBody Post post) throws JsonProcessingException {
        List<Post> readPost = postService.findPost(post);
        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.writeValueAsString(readPost);
    }

    @PostMapping("edit")
    public String editConfirm(@RequestParam("file") MultipartFile file, @RequestParam("data") String jsonData){
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            Post post = objectMapper.readValue(jsonData, Post.class);
            String imgLocation = imgUploadService.PostImgUpload(file, post.getUserId());
            post.setImgLocation(imgLocation);

            postService.modify(post);

            return "ok";
        }catch (Exception e){
            return "에러 발생";
        }

    }

    @PostMapping("/delete")
    public String delete(@RequestBody Post post){
        try {
            postService.delete(post);
            return "ok";
        }catch (Exception e){
            return "에러 발생";
        }
    }

    @PostMapping("/search")
    public List<Post> search(@RequestBody User user, @RequestBody Post post, @RequestBody LocalDate formerDate, @RequestBody LocalDate afterDate){
        return postService.search(user, post, formerDate, afterDate);
    }

    @PostMapping("/find-mypost-bycontent")
    public String findMyPostByContents(@RequestBody Post post,@RequestBody User user){
        try {
            postService.findMyPostByContents(post, user);
            return "ok";
        }catch (Exception e){
            return "에러 발생"; 
        }
    }

    @PostMapping("/find-follower")
    public String findPostOfFollower(@RequestBody User user){
        try {
            postService.findPostByFollower(user);
            return "ok";
        }catch (Exception e){
            return "에러 발생"; 
        }
    }

    @PostMapping("/find-likepost")
    public String findLikePost(@RequestBody User user){
        try {
            postService.findAllLikePost(user);
            return "ok";
        }catch (Exception e){
            return "에러 발생"; 
        }
    }

}
