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
import java.util.Base64;
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

    @PostMapping(value = "/submit")
    public String submitPost(@RequestParam("file") MultipartFile file, @RequestBody Post post) {
        try {
            String imgLocation = imgUploadService.PostImgUpload(file, post.getUserId());
            post.setImgLocation(imgLocation);

            postService.submit(post);

            return "ok";
        }catch (Exception e){
            return "에러 발생";
        }
    }

    @PostMapping(value = "/read")
    public String read(@RequestBody Post post) throws IOException {
        return postService.findPost(post).toString();
    }

    @PatchMapping(value = "edit")
    public String editConfirm(@RequestParam(value = "file", required = false) MultipartFile file, @RequestBody Post post){
        try {
            String imgLocation = imgUploadService.PostImgUpload(file, post.getUserId());
            post.setImgLocation(imgLocation);

            postService.modify(post);

            return "ok";
        }catch (Exception e){
            return "에러 발생";
        }

    }

    @PostMapping(value = "/delete")
    public String delete(@RequestBody Post post){
        try {
            postService.delete(post);
            return "ok";
        }catch (Exception e){
            return "에러 발생";
        }
    }


    @PostMapping(value = "/search")
    public List<Post> search(@RequestBody(required = false) Post post, @RequestBody(required = false) LocalDate formerDate, @RequestBody(required = false) LocalDate afterDate) throws IOException {
        return postService.search(post, formerDate, afterDate);
    }

    @PostMapping(value = "/find-follower")
    public List<Post> findPostOfFollower(@RequestBody User user) throws IOException {
        return postService.findPostByFollower(user);
    }

    @PostMapping(value = "/find-likepost")
    public List<Post> findLikePost(@RequestBody User user) throws IOException {
        return postService.findAllLikePost(user);
    }
}
