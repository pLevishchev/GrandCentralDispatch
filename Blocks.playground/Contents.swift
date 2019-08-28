import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let workItem = DispatchWorkItem(qos: .utility, flags: .detached) {
    print("performing workitem")
}

//workItem.perform()

let queue = DispatchQueue(label: "test",
                           qos: .utility,
                           attributes: .concurrent,
                           autoreleaseFrequency: .workItem,
                           target: DispatchQueue.global(qos: .userInteractive))

queue.asyncAfter(deadline: .now() + 1, execute: workItem)

workItem.notify(queue: .main) {
    print("worItem is completed")
}

workItem.isCancelled
workItem.cancel()
workItem.isCancelled

workItem.wait()
