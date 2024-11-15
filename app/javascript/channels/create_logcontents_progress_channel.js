import consumer from "channels/consumer";

if (!consumer.subscriptions.findAll("CreateLogcontentsProgressChannel").length) {
  consumer.subscriptions.create("CreateLogcontentsProgressChannel", {
    connected() {
      console.log("Connected to CreateLogcontentsProgressChannel");
    },

    disconnected() {
      console.log("Disconnected from CreateLogcontentsProgressChannel");
    },

    received(data) {
      console.log("Received data:", data);
      queueMicrotask(() => {
        let notion_item = document.getElementById("notion_container").querySelector(`[job="${data.job_id}"]`);
        let label = notion_item?.querySelector("span");
        let progressbar = notion_item?.querySelector("progress");
        if (!notion_item) {
          notion_item = document.createElement("li");
          notion_item.dataset.status = "running";
          notion_item.setAttribute("job", data.job_id);
          document.getElementById("notion_container").appendChild(notion_item);
          label = document.createElement("span");
          label.textContent = `作成中：${data.name}`;
          notion_item.appendChild(label);
        }

        if (data.progress == 0) {
          // キュー追加時
          label.textContent = `待機中：${data.name}`;
        } else if (data.progress != data.max) {
          // 進行中
          if (!progressbar) {
            progressbar = document.createElement("progress");
            progressbar.setAttribute("max", data.max);
            notion_item.appendChild(progressbar);
          }
          progressbar.setAttribute("value", data.progress);
        } else {
          //完了
          notion_item.dataset.status = "complate";
          label.textContent = ` 完了 ：${data.name}`;
          progressbar?.remove();

        }

      });
    }
  });
}