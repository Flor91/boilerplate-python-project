from typing import Any

import sentry_sdk
from structlog import get_logger

from app.config import config

logger = get_logger(__name__)


def configure_sentry(**kwargs: Any) -> None:
    if not config.sentry_dsn:
        logger.info("not configuring sentry")
        return

    sentry_sdk.init(
        debug=False,
        dsn=config.sentry_dsn,
        environment=config.env_name,
        traces_sample_rate=1.0,
        release=config.git_commit_short,
        **kwargs,
    )
