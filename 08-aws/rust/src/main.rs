mod lambda;

use lambda_runtime::{service_fn, Error};

#[tokio::main]
async fn main() -> Result<(), Error> {
    // Setup tracing subscriber for structured logging
    tracing_subscriber::fmt()
        .json()
        .with_env_filter(tracing_subscriber::filter::EnvFilter::from_default_env())
        .with_max_level(tracing::Level::INFO)
        .with_target(false)
        .with_current_span(false)
        .without_time()
        .init();

    // Start the Lambda handler
    lambda_runtime::run(service_fn(lambda::run_lambda)).await
}
