//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 김승찬 on 2023/09/07.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Core",
    product: .staticFramework,
    dependencies: [
        .project(target: "Service", path: .relativeToRoot("Projects/Service"))
    ],
    resources: ["Resources/**"]
)
