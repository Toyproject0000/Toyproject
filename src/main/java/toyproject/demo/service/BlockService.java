package toyproject.demo.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import toyproject.demo.domain.Post;
import toyproject.demo.domain.User;
import toyproject.demo.repository.BlockRepository;

import java.util.List;

@Service
@RequiredArgsConstructor
public class BlockService {
    private final FindAlgorithm algorithm;
    private final BlockRepository blockRepository;
    public String blockUser(String userId, String id) {
        try {
            blockRepository.blockUser(userId, id);
        }
        catch (Exception e){
            return "cancel";
        }
        return "ok";
    }

    public String blockPost(String userId, Post post) {
        try {
            blockRepository.blockPost(userId, post.getId());
            algorithm.block(post, userId);
        }
        catch (Exception e){
            return "cancel";
        }
        return "ok";
    }

    public String reportUser(String userId, String id, String reason) {
        try {
            blockRepository.reportUser(userId, id, reason);
        }
        catch (Exception e){
            return "cancel";
        }
        return "ok";
    }

    public String reportPost(String userId, Post post, String reason) {
        try {
            blockRepository.reportPost(userId, post.getId(), reason);
            algorithm.block(post, userId);
        }
        catch (Exception e){
            return "cancel";
        }
        return "ok";
    }

    public String cancelBlockUser(String userId, String id){
        try {
            blockRepository.cancelBlockUser(userId, id);
        }
        catch (Exception e){
            return "cancel";
        }
        return "ok";
    }

    public String cancelReportUser(String userId, String id){
        try {
            blockRepository.cancelReportUser(userId, id);
        }
        catch (Exception e){
            return "cancel";
        }
        return "ok";
    }
    public String cancelBlockPost(String userId, Long id){
        try {
            blockRepository.cancelBlockPost(userId, id);
        }
        catch (Exception e){
            return "cancel";
        }
        return "ok";
    }

    public String cancelReportPost(String userId, Long id){
        try {
            blockRepository.cancelReportPost(userId, id);
        }
        catch (Exception e){
            return "cancel";
        }
        return "ok";
    }


    public List<User> findBlockUser(String userId){
        List<User> users;
        try {
            users = blockRepository.findBlockUser(userId);
        }
        catch (Exception e){
            return null;
        }
        return users;
    }

    public List<Post> findBlockPost(String userId){
        List<Post> posts;
        try {
            posts = blockRepository.findBlockPost(userId);
        }
        catch (Exception e){
            return null;
        }
        return posts;
    }

    public List<Post> findReportPost(String userId){
        List<Post> posts;
        try {
            posts = blockRepository.findReportPost(userId);
        }
        catch (Exception e){
            return null;
        }
        return posts;
    }

    public List<User> findReportUser(String userId){
        List<User> users;
        try {
            users = blockRepository.findReportUser(userId);
        }
        catch (Exception e){
            return null;
        }
        return users;
    }
}
