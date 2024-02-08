from structlog import get_logger

logger = get_logger(__name__)


def hello(name: str) -> None:
    logger.info("saying hello", name=name)
