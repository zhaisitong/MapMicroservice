from google.cloud import pubsub_v1
import logging
import uuid
from google.api_core.exceptions import GoogleAPIError

from src.mutation.constants import MESSAGE_GROUP_GENERAL_MUTATION
from src.mutation.proto_py.mutation_pb2 import MutationRequests


class MutationProducer:
    """
    It encapsulates the sending of graph mutations to a Google Cloud Pub/Sub topic.
    """

    def __init__(self, project_id: str, topic_name: str) -> None:
        self.publisher = pubsub_v1.PublisherClient()
        self.topic_path = self.publisher.topic_path(project_id, topic_name)

    def Produce(self, mutations: MutationRequests) -> bool:
        """Sends a batch of mutations as a single message to a Pub/Sub topic.

        Args:
            mutations (MutationRequests): The batch of mutations to send to the
                topic.

        Returns:
            bool: It returns True only when the mutations are successfully
                sent to the topic.
        """
        try:
            # Google Cloud Pub/Sub does not directly support MessageGroupId and MessageDeduplicationId like SQS
            # If you need ordering, you must configure message ordering in the topic and use the ordering_key parameter
            # For deduplication, you'd typically manage this application-side or use Pub/Sub features like exactly-once delivery
            self.publisher.publish(
                self.topic_path,
                data=mutations.SerializeToString(),
                # You can add attributes here if needed, for example, to replace MessageGroupId
                # attributes={'message_group_id': MESSAGE_GROUP_GENERAL_MUTATION}
            )
            return True
        except GoogleAPIError as error:
            logging.exception(f"ProduceMutations failed to send messages to topic: {self.topic_path}")
            raise error
