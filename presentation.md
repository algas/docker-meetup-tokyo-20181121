title: Stress Test with LOCUST on k8s
class: animation-fade
layout: true

<!-- This slide will serve as the base layout for all your slides -->
.bottom-bar[
  ![Plaid Logo](https://algas.github.io/docker-meetup-tokyo-20181121/resource/plaid_logo_white.png)
]

---

class: impact

# {{title}}
## @algas

---

# 自己紹介

## 株式会社プレイド
Engineer / Hunter  
山内 雅浩 ([@algas](https://github.com/algas))

- [LinuxKit で実現する新しい Docker 実行環境](https://tech.plaid.co.jp/linuxkit-tutorial/)
- [Haskell on Docker で Portable CLI を作ろう](https://qiita.com/algas/items/fde155abbc9d8ae3f8c9)
- [Whalebrew でコマンドパッケージを作ろう (GNU date を作ってみた)](https://qiita.com/algas/items/66aaf749dc3979e03a46)
- [【KUFU(SmartHR)×プレイド】Tech Meetup ~Docker編~を開催しました！](https://tech.plaid.co.jp/kufu-docker-meetup/)

---

# 今日の発表内容

- 負荷テストについて
- LOCUSTの紹介
- ローカル環境でLOCUSTを動かす
- クラウド環境でLOCUSTを動かす
- LOCUSTの使用上の注意点

---

# 負荷テストについて

負荷テスト=自社のWebサイトが大量のアクセスに耐えられることを確認するテスト

--

## 負荷テストの何が難しいのか？
--

- 負荷をかける方にも十分な性能がないと適切な量の負荷をかけることができない
--

- 1台だけでテストを実行するとネットワークやポートがボトルネックになりやすい
--

- 複数台から実行するにはテスト実行の同期や結果データの統合が必要になる

--

## → 負荷テストツールを使おう

---

class: locust

# LOCUSTの紹介

![LOCUST Logo](https://locust.io/static/img/logo.png)

```python
from locust import HttpLocust, TaskSet, task

class UserBehavior(TaskSet):
    @task(1)
    def index(self):
        self.client.get("/index.html")

class WebsiteUser(HttpLocust):
    task_set = UserBehavior

```

---

# LOCUSTの紹介

## PROS
- 複数台からテストを簡単に実行する仕組みが用意されている
- Python を使ってテストケースを記述できる
- レポート機能がある (Web/CSV)

## CONS
- レコーディング機能がない
- HTTP(S) 以外のプロトコルに対応していない

---

# ローカル環境でLOCUSTを動かす

LOCUST をインストールせずに Docker で動作させる環境を作りました！
https://github.com/algas/locust-example

--

1. `git clone https://github.com/algas/locust-example.git`  
1. `cd locust-example && ./web`
1. `./locust -f locustfile.py --host http://host.docker.internal:8888`
1. http://localhost:8089

---

class: two-columns

# クラウド環境でLOCUSTを動かす

.col-6[
## 構成図
[Distributed Load Testing Using Kubernetes](https://github.com/GoogleCloudPlatform/distributed-load-testing-using-kubernetes)
<img src="https://algas.github.io/docker-meetup-tokyo-20181121/resource/locust_cluster.png" alt="locust-cluster" class="two-columns">
]

--

.col-6[
## 構築・実行手順
1. kubernetes cluster を作成する
1. master controller をデプロイする
1. master service をデプロイする
1. worker controller をデプロイする
1. (必要があれば) worker 台数を変更する
1. テストを実行する
]

---

class: two-columns

# クラウド環境でLOCUSTを動かす

.col-6[
## Web UI
<img src="https://docs.locust.io/en/stable/_images/webui-splash-screenshot.png" alt="locust-ui" class="two-columns">
]

--

.col-6[
## テストの実行
1. Number of users to simulate
1. Hatch rate
1. "Start swarming"
]

---

# LOCUSTの使用上の注意点

--

## Number of users は徐々に大きくする

管理外のサーバに大量のリクエストを送るとDOS攻撃とみなされる可能性があります。  
ログを見て動作を確認してから少しずつ Number of users を大きくしましょう。

--

## Hatch rate は小さく

Hatch rate の値が大きいとリクエストを投げるのに失敗することがあります。  
暖気は大切！

---

# 発表のまとめ

- 負荷テストではLOCUSTを使うと良さげ
- LOCUSTは複数台でもテストの実行環境が構築できる
- kubernetesで環境構築すれば簡単に台数調整ができる

今日の発表資料は以下で公開しています。  
https://algas.github.io/docker-meetup-tokyo-20181121/presentation

---

class: impact

# 最後に宣伝

## 株式会社プレイドでは一緒に未来を作ってくれる
## エンジニアを募集しています！

https://plaid.co.jp/recruit/engineer.html

---

# Appendix

- 負荷テストツールの比較
- 参考資料

---

# 負荷テストツールの比較

- [JMeter](https://jmeter.apache.org/)
    - PROS: プロトコルの種類が豊富で複数台からの実行にも対応している
    - CONS: 古代のGUIでテストケースファイルがXML
- [Apache Bench (ab)](https://httpd.apache.org/docs/2.4/programs/ab.html)
    - PROS: コマンドラインベースのシンプルなツール
    - CONS: GUIがなく複数台からのテスト実行には対応していない

---

# 参考資料

- [LOCUST.io](https://locust.io/)
- [Distributed Load Testing Using Kubernetes](https://github.com/GoogleCloudPlatform/distributed-load-testing-using-kubernetes)
