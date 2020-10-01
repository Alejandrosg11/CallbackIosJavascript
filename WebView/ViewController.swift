//
//  ViewController.swift
//  WebView
//
//  Created by Alejandro Santamaria Gomez on 01/10/20.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKScriptMessageHandler {
    let content = """
    <!DOCTYPE html><html><body>
    <button onclick="onClick()">YOLOO</button>
    <script>
    function onClick() {
      window.webkit.messageHandlers.backHomePage.postMessage("success");
    }
    </script>
    </body></html>
    """

    override func viewDidLoad() {
      super.viewDidLoad()

      let config = WKWebViewConfiguration()
      config.userContentController = WKUserContentController()
      config.userContentController.add(self, name: "backHomePage")

      let webView = WKWebView(frame: CGRect(x: 100, y: 100, width: 200, height: 200), configuration: config)

      view.addSubview(webView)

        webView.load(URLRequest(url: URL(string: "https://alejandrosg11.github.io/widgetTest/widget-success")!))
        //webView.loadHTMLString(content, baseURL: URL(string: "https://alejandrosg11.github.io/widgetTest/widget-success"))
    }

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
      print(message.body)
        if let viewController = UIStoryboard(name: "success", bundle: nil).instantiateViewController(withIdentifier: "SuccessViewController") as? SuccessViewController {
            if let navigator = self.navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
}


}
