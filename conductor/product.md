# Product Definition - DriveTools

## Vision
`DriveTools` is an optimized, high-performance PowerShell module designed to audit, organize, deduplicate, and maintain large-capacity external storage drives (3 TB+). It aims to offer advanced, reliable storage maintenance tools through a fast CLI suite for power users and automation scripts, alongside a modern, fully asynchronous WPF GUI launcher that executes disk traversals in background runspaces without locking the UI thread.

## Core Features
1. **Asynchronous Fast Audit**: Recursively scans target paths using optimized C# `BlockingCollection` pipelines to decouple disk traversal from logging. Outputs file metadata reports directly to CSV.
2. **Dynamic Hash Caching**: Computes SHA256 hashes for files, caching them in an embedded SQLite database or local JSON cache. It avoids redundant hashing by checking file modification times.
3. **Automated Categorization**: Sorts files into distinct category directories (`Projects`, `Media`, `Archives`, `Uploads`, `System`) using configurable file patterns and keyword rules.
4. **Duplicate File Resolution**: Identifies exact duplicate files via SHA256 hashes and safely purges redundant copies while preserving the most recently modified instances.
5. **Disk Maintenance & Cleanup**: Cleans empty directory hierarchies, reports duplicate space savings, and performs zip compression on archives.
6. **Console Visualization**: Renders an intuitive tree map of folders with Unicode box-drawing characters, exported as visual text files.
7. **Scheduled Automation**: Registers Windows Scheduled Tasks to automatically run background maintenance and drive health reporting.
