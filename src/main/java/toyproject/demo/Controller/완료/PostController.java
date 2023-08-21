package toyproject.demo.Controller.완료;

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

    @PostMapping(value = "/submit", produces = "application/json;charset=UTF-8")
    public String submitPost(@RequestParam(required = false) MultipartFile file,
                             @RequestParam String userId,
                             @RequestParam String contents,
                             @RequestParam String title,
                             @RequestParam String category,
                             @RequestParam String disclosure,
                             @RequestParam String possibleReply) {
        Post post = new Post();
        try {
            post.setUserId(userId);
            post.setContents(contents);
            post.setTitle(title);
            post.setCategory(category);
            post.setDisclosure(disclosure);
            post.setPossiblyReply(possibleReply);
            if(file != null ){
            String imgLocation = imgUploadService.PostImgUpload(file, userId);
            post.setImgLocation(imgLocation);}

            postService.submit(post);

            return "ok";
        }catch (Exception e){
            System.out.println(e.getMessage());
            return "에러 발생";
        }
    }

    @PatchMapping(value = "/edit", produces = "application/json;charset=UTF-8")
    public String editConfirm(@RequestParam(required = false) MultipartFile file,
                              @RequestParam String userId,
                              @RequestParam String contents,
                              @RequestParam String title,
                              @RequestParam String category,
                              @RequestParam String disclosure,
                              @RequestParam String possibleReply){
        Post post = new Post();
        try {
            post.setUserId(userId);
            post.setContents(contents);
            post.setTitle(title);
            post.setCategory(category);
            post.setDisclosure(disclosure);
            post.setPossiblyReply(possibleReply);
            if(file != null ){
                String imgLocation = imgUploadService.PostImgUpload(file, userId);
                post.setImgLocation(imgLocation);
            }

            postService.modify(post);
        }catch (Exception e){
            return "에러 발생";
        }
        return "ok";
    }

    @PostMapping(value = "/delete", produces = "application/json;charset=UTF-8")
    public String delete(@RequestBody Post post){
        try {
            postService.delete(post);
            return "ok";
        }catch (Exception e){
            return "에러 발생";
        }
    }

    @PostMapping(value = "/search", produces = "application/json;charset=UTF-8")
    public List<Post> search(@RequestBody(required = false) Post post,
                             @RequestBody(required = false) LocalDate formerDate,
                             @RequestBody(required = false) LocalDate afterDate) throws IOException {

        return postService.search(post, formerDate, afterDate);
    }

    @PostMapping(value = "/find-follower", produces = "application/json;charset=UTF-8")
    public Optional<List<Post>> findPostOfFollower(@RequestBody User user){
        return Optional.ofNullable(postService.findPostByFollower(user));
    }

    @PostMapping(value = "/find-likepost", produces = "application/json;charset=UTF-8")
    public Optional<List<Post>> findLikePost(@RequestBody User user){
        return Optional.ofNullable(postService.findAllLikePost(user));
    }

    /**
     *
     * @param post
     * @param userId
     */
    @PostMapping
    public void read(@RequestBody Post post, @RequestBody String userId){
        algorithm.read(post, userId);
    }

}
