package toyproject.demo.repository;


import toyproject.demo.domain.PostLike;



public interface PostLikeRepository {
    public void insert(PostLike postlike);
    public void delete(PostLike postLike);
}
