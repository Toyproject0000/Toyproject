package toyproject.demo.repository;

import toyproject.demo.domain.Post;
import toyproject.demo.domain.Reply;
import toyproject.demo.domain.User;

import java.util.List;

public interface ReplyRepository {
    public void insert(Reply reply);
    public void update(Reply reply);
    public List<Post> findAll();
    public List<Post> findReplyOfPost(Post post);
}
