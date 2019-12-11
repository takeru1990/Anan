#!/bin/bash
 
# ログイン情報
id="メールアドレス"
pw="パスワード"
 
# ログインして cookie を作成
curl --basic -u $id:$pw https://anchor.fm/api/login -H "accept: application/json" -c cookie
 
# エピソードの数を取得
limit=`curl -b cookie https://anchor.fm/api/podcastepisode | jq ".totalPodcastEpisodes"`
 
# エピソードの数だけデータを取得
json=`curl -b cookie https://anchor.fm/api/podcastepisode?limit=$limit | jq ".podcastEpisodes"`
 
# 各エピソードの再生回数を含む配列を作成
for i in `seq 0 $(expr $limit - 1)`
do
    #title=`echo $json | jq .[${i}].title`
    downloads=`echo $json | jq .[$i].downloads`
 
    #echo "$title $downloads"
    arr+=($downloads)
done
 
echo ${arr[@]}
