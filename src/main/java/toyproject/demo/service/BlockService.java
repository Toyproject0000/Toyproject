package toyproject.demo.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import toyproject.demo.domain.DTO.BlockUserDTO;
import toyproject.demo.domain.Post;
import toyproject.demo.domain.User;
import toyproject.demo.repository.BlockRepository;

import java.util.List;

@Service
@RequiredArgsConstructor
public class BlockService {
    private final FindAlgorithm algorithm;
    private final BlockRepository blockRepository;
    public String blockUser(String userId, String id, String userRoot, String root) {
        try {
            blockRepository.blockUser(userId, id, userRoot, root);
        }
        catch (Exception e){
            System.out.println("e.getMessage() = " + e.getMessage());
            return "cancel";
        }
        return "ok";
    }

    public String blockPost(String userId, Long postId, String root) {
        try {
            blockRepository.blockPost(userId, postId, root);
//            algorithm.block(postId, userId);
        }
        catch (Exception e){
            System.out.println("e.getMessage() = " + e.getMessage());
            return "cancel";
        }
        return "ok";
    }

    public String reportUser(String userId, String id, String reason, String userRoot, String root) {
        try {
            blockRepository.reportUser(userId, id, reason, userRoot, root);
        }
        catch (Exception e){
            System.out.println(e.getMessage());
            return "cancel";
        }
        return "ok";
    }

    public String reportPost(String userId, Long postId, String reason, String userRoot) {
        try {
            blockRepository.reportPost(userId, postId, reason, userRoot);
//            algorithm.block(post, userId);
        }
        catch (Exception e){
            System.out.println(e.getMessage());
            return "cancel";
        }
        return "ok";
    }

    public String cancelBlockUser(String userId, String id, String userRoot, String root){
        try {
            blockRepository.cancelBlockUser(userId, id, userRoot, root);
        }
        catch (Exception e){
            System.out.println(e.getMessage());
            return "cancel";
        }
        return "ok";
    }

    public String cancelReportUser(String userId, String id, String userRoot, String root){
        try {
            blockRepository.cancelReportUser(userId, id, userRoot, root);
        }
        catch (Exception e){
            return "cancel";
        }
        return "ok";
    }
    public String cancelBlockPost(String userId, Long id, String root){
        try {
            blockRepository.cancelBlockPost(userId, id, root);
        }
        catch (Exception e){
            System.out.println(e.getMessage());
            return "cancel";
        }
        return "ok";
    }

    public String cancelReportPost(String userId, Long id, String userRoot){
        try {
            blockRepository.cancelReportPost(userId, id, userRoot);
        }
        catch (Exception e){
            return "cancel";
        }
        return "ok";
    }


    public List<User> findBlockUser(String userId, String root){
        List<User> users;
        try {
            users = blockRepository.findBlockUser(userId, root);
        }
        catch (Exception e){
            System.out.println(e.getMessage());
            return null;
        }
        return users;
    }

    public List<Post> findBlockPost(String userId, String root){
        List<Post> posts;
        try {
            posts = blockRepository.findBlockPost(userId, root);
        }
        catch (Exception e){
            System.out.println(e.getMessage());
            return null;
        }
        return posts;
    }

    public List<Post> findReportPost(String userId, String userRoot){
        List<Post> posts;
        try {
            posts = blockRepository.findReportPost(userId, userRoot);
        }
        catch (Exception e){
            System.out.println(e.getMessage());
            return null;
        }
        return posts;
    }

    public List<User> findReportUser(String userId, String userRoot){
        List<User> users;
        try {
            users = blockRepository.findReportUser(userId, userRoot);
        }
        catch (Exception e){
            return null;
        }
        return users;
    }
}
