#.................................... Source Code Repository .................................#

output "repo_details" {
    value = google_sourcerepo_repository.gcp-org-repo
}

/* output "repo_name" {
    value = google_sourcerepo_repository.gcp-org-repo.name
}
output "repo_id" {
    value = google_sourcerepo_repository.gcp-org-repo.id
}
output "repo_url" {
    value = google_sourcerepo_repository.gcp-org-repo.url
}
output "repo_size" {
    value = google_sourcerepo_repository.gcp-org-repo.size
} */