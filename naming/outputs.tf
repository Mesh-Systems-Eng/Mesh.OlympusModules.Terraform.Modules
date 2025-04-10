// Copyright © 2025 Mesh Systems LLC.  All rights reserved.

output "sharedNamingPrefix" {
  description = "Shared naming prefix"
  value       = local.sharedNamingPrefix
}

output "instanceNamingPrefix" {
  description = "Instance naming prefix"
  value       = local.instanceNamingPrefix
}

output "sharedResourceNames" {
  description = "Names for shared resources"
  value       = local.resourceNames
}