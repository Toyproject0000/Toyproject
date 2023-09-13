package toyproject.demo.Controller;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import toyproject.demo.converter.PostConverter;
import toyproject.demo.converter.UserConverter;
import toyproject.demo.domain.DTO.PostWithTokenDTO;
import toyproject.demo.domain.DTO.UserWithTokenDTO;
import toyproject.demo.domain.Post;
import toyproject.demo.domain.User;
import toyproject.demo.service.FindAlgorithm;
import toyproject.demo.service.ImgUploadService;
import toyproject.demo.service.JwtTokenUtil;
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
    private final JwtTokenUtil tokenUtil;
    private final PostConverter postConverter;
    private final UserConverter userConverter;

    @PostMapping(value = "/submit", produces = "application/json;charset=UTF-8")
    public String submitPost(@RequestParam(required = false) MultipartFile file,
                             @RequestParam String userId,
                             @RequestParam String contents,
                             @RequestParam String title,
                             @RequestParam String category,
                             @RequestParam String disclosure,
                             @RequestParam String possibleReply,
                             @RequestParam String visiblyLike,
                             @RequestParam String root,
                             @RequestParam String token) {
        try {
            tokenUtil.parseJwtToken(token);
        }catch (Exception e){
            return null;
        }

        Post post = new Post();
        try {
            post.setUserId(userId);
            post.setVisiblyLike(visiblyLike);
            post.setRoot(root);
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

    @PostMapping(value = "/edit", produces = "application/json;charset=UTF-8")
    public String editConfirm(@RequestParam(required = false) MultipartFile file,
                              @RequestParam String userId,
                              @RequestParam String root,
                              @RequestParam(required = false) String contents,
                              @RequestParam(required = false) String title,
                              @RequestParam(required = false) String category,
                              @RequestParam(required = false) String disclosure,
                              @RequestParam(required = false) String possibleReply,
                              @RequestParam Long id,
                              @RequestParam String visiblyLike,
                              @RequestParam String token){
        try {
            tokenUtil.parseJwtToken(token);
        }catch (Exception e){
            return null;
        }
        Post post = new Post();
        try {
            post.setId(id);
            post.setUserId(userId);
            post.setContents(contents);
            post.setRoot(root);
            post.setVisiblyLike(visiblyLike);
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
    public String delete(@RequestBody PostWithTokenDTO tokenPost){
        try {
            tokenUtil.parseJwtToken(tokenPost.getToken());
        }catch (Exception e){
            return null;
        }
        Post post = postConverter.convert(tokenPost);
        try {
            postService.delete(post);
            return "ok";
        }catch (Exception e){
            return "에러 발생";
        }
    }

    @PostMapping(value = "/search", produces = "application/json;charset=UTF-8")
    public List<Post> search(@RequestBody(required = false) SearchData data) throws IOException {
        PostWithTokenDTO tokenPost = data.getTokenPost();
        LocalDate afterDate = data.getAfterDate();
        LocalDate formerDate = data.getFormerDate();
        try {
            tokenUtil.parseJwtToken(tokenPost.getToken());
        }catch (Exception e){
            System.out.println("e.getMessage() = " + e.getMessage());
        }
        Post post = postConverter.convert(tokenPost);

        return postService.search(post, formerDate, afterDate);
    }

    @PostMapping(value = "/find-follower", produces = "application/json;charset=UTF-8")
    public Optional<List<Post>> findPostOfFollower(@RequestBody UserWithTokenDTO tokenUser){
        try {
            tokenUtil.parseJwtToken(tokenUser.getToken());
        }catch (Exception e){
            return null;
        }
        User user = userConverter.convert(tokenUser);


        return Optional.ofNullable(postService.findPostByFollower(user));
    }

    @PostMapping(value = "/find-likepost", produces = "application/json;charset=UTF-8")
    public Optional<List<Post>> findLikePost(@RequestBody UserWithTokenDTO tokenUser){
        try {
            tokenUtil.parseJwtToken(tokenUser.getToken());
        }catch (Exception e){
            return null;
        }
        User user = userConverter.convert(tokenUser);
        return Optional.ofNullable(postService.findAllLikePost(user));
    }

    /**
     *
     * @param post
     */
    @PostMapping
    public void read(@RequestBody Post post){
        algorithm.read(post, post.getUserId());
    }

    @Getter
    @Setter
    private static class SearchData{
        PostWithTokenDTO tokenPost;
        LocalDate formerDate;
        LocalDate afterDate;
    }

}
