//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 김승찬 on 2023/08/31.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Feature",
    product: .staticFramework,
    dependencies: [
        .project(target: "Service", path: .relativeToRoot("Projects/Service"))
    ],
    resources: ["Resources/**"]
)
