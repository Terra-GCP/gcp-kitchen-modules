#.................................... Scheduler .................................#

output "job_scheduler_details" {
    value = google_cloud_scheduler_job.job
}

/* output "job_scheduler_name" {
    value = google_cloud_scheduler_job.job.name
}
output "job_schedule" {
    value = google_cloud_scheduler_job.job.schedule
}
output "job_scheduler_time_zone" {
    value = google_cloud_scheduler_job.job.time_zone
} */