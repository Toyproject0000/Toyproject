package toyproject.demo.Controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import toyproject.demo.domain.Post;
import toyproject.demo.domain.User;
import toyproject.demo.service.FindAlgorithm;
import toyproject.demo.service.ImgUploadService;
import toyproject.demo.service.PostService;

import java.io.IOException;
import java.time.LocalDate;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/post")
@RequiredArgsConstructor
public class PostController {
    private final PostService postService;
    private final ImgUploadService imgUploadService;
    private final FindAlgorithm algorithm;

    @PostMapping(value = "/submit")
    public String submitPost(@RequestBody Post post, @SessionAttribute(value = "SessionId", required = false) String userId) {
//        if (post.getUserId()!=userId)
//            return "잘못된 요청입니다.";

        try {
//            String imgLocation = imgUploadService.PostImgUpload(file, post.getUserId());
//            post.setImgLocation(imgLocation);
            post.setImgLocation("1");

            postService.submit(post);

            return "ok";
        }catch (Exception e){
            return "에러 발생";
        }
    }

    @PatchMapping(value = "edit")
    public String editConfirm(@RequestParam(value = "file", required = false) MultipartFile file, @RequestBody Post post, @SessionAttribute("SessionId") String userId){
        if (post.getUserId()!=userId)
            return "잘못된 요청입니다.";
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
    public String delete(@RequestBody Post post, @SessionAttribute("SessionId") String userId){
        if (post.getUserId()!=userId)
            return "잘못된 요청입니다.";
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
    public Optional<List<Post>> findPostOfFollower(@RequestBody User user, @SessionAttribute("SessionId") String userId) throws IOException {
        if (user.getId()!=userId)
            return null;
        return Optional.ofNullable(postService.findPostByFollower(user));
    }

    @PostMapping(value = "/find-likepost")
    public Optional<List<Post>> findLikePost(@RequestBody User user, @SessionAttribute("SessionId") String userId) throws IOException {
        if (user.getId()!=userId)
            return null;
        return Optional.ofNullable(postService.findAllLikePost(user));
    }

    @PostMapping
    public void read(@SessionAttribute("SessionId")String userId, @RequestBody Post post){
        algorithm.read(post, userId);
    }

}
