


let queue = DispatchQueue(label: "test", attributes: .concurrent)
let group = DispatchGroup()

queue.async(group: group) {
    for i in 0...10 {
        if i == 10 {
            print(i)
        }
    }
}


queue.async(group: group) {
    for i in 0...20 {
        if i == 20 {
            print(i)
        }
    }
}

group.notify(queue: .main) {
    print("все закончено в группе: group")
}

let secondGroup = DispatchGroup()
secondGroup.enter()
queue.async(group: group) {
    for i in 0...30 {
        if i == 30 {
            print(i)
            secondGroup.leave()
        }
    }
}

let result = secondGroup.wait(timeout: .now() + 3)
print(result)

secondGroup.notify(queue: .main) {
    print("secondGroup")
}

secondGroup.wait()
