
CREATE TABLE `Inbox` (
  `InboxId` int(11) NOT NULL AUTO_INCREMENT,
  `MasterId` varchar(36) NOT NULL,
  `RebateSponsorMasterId` varchar(36) NOT NULL,
  `Name` varchar(256) NOT NULL,
  `EffectiveDateTime` datetime NOT NULL,
  `ExpiredDateTime` datetime DEFAULT NULL,
  `CreatedDateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ModifiedDateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`InboxId`),
  UNIQUE KEY `UXAK_MasterId` (`MasterId`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=latin1
CREATE TABLE `XRef` (
  `XRefId` int(11) NOT NULL AUTO_INCREMENT,
  `MasterId` varchar(36) NOT NULL,
  `ReferenceSet` varchar(50) NOT NULL,
  `Value` varchar(100) DEFAULT NULL,
  `EffectiveDateTime` datetime NOT NULL,
  `ExpiredDateTime` datetime DEFAULT NULL,
  `IsActive` tinyint(1) DEFAULT NULL,
  `CreatedDateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ModifiedDateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`XRefId`),
  UNIQUE KEY `UXAK_MasterId` (`MasterId`),
  UNIQUE KEY `XRef_ReferenceSet_Value` (`ReferenceSet`,`Value`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1
CREATE TABLE `Workflow` (
  `WorkflowId` int(11) NOT NULL AUTO_INCREMENT,
  `MasterId` varchar(36) NOT NULL,
  `RebateSponsorMasterId` varchar(36) NOT NULL,
  `WorkflowTypeXRefId` int(11) NOT NULL,
  `ApprovalLevels` int(10) unsigned NOT NULL,
  `DefaultSubmissionInboxId` int(11) NOT NULL,
  `EffectiveDateTime` datetime NOT NULL,
  `ExpiredDateTime` datetime DEFAULT NULL,
  `CreatedDateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ModifiedDateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`WorkflowId`),
  UNIQUE KEY `UXAK_Workflow_RebateSponsor_WorkflowType` (`RebateSponsorMasterId`,`WorkflowTypeXRefId`),
  UNIQUE KEY `UXAK_MasterId` (`MasterId`),
  KEY `IXFK_Workflow_RebateSponsor` (`RebateSponsorMasterId`),
  KEY `IXFK_Workflow_XRef` (`WorkflowTypeXRefId`),
  KEY `Workflow_DefaultSubmissionInbox_Inbox` (`DefaultSubmissionInboxId`),
  CONSTRAINT `FK_Workflow_XRef` FOREIGN KEY (`WorkflowTypeXRefId`) REFERENCES `XRef` (`XRefId`),
  CONSTRAINT `Workflow_DefaultSubmissionInbox_Inbox` FOREIGN KEY (`DefaultSubmissionInboxId`) REFERENCES `Inbox` (`InboxId`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1
CREATE TABLE `WorkflowItem` (
  `WorkflowItemId` int(11) NOT NULL AUTO_INCREMENT,
  `MasterId` varchar(36) NOT NULL,
  `WorkflowId` int(11) NOT NULL,
  `WorkflowStateXRefId` int(11) NOT NULL,
  `PartyMasterId` varchar(36) NOT NULL,
  `SubmitterPartyMasterId` varchar(36) NOT NULL,
  `InboxId` int(11) DEFAULT NULL,
  `IsTerminal` tinyint(4) NOT NULL,
  `EffectiveDateTime` datetime NOT NULL,
  `ExpiredDateTime` datetime DEFAULT NULL,
  `CreatedDateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ModifiedDateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ExternalItemId` varchar(36) NOT NULL,
  PRIMARY KEY (`WorkflowItemId`),
  UNIQUE KEY `UXAK_MasterId` (`MasterId`),
  KEY `IXFK_WorkflowItem_Inbox` (`InboxId`),
  KEY `IXFK_WorkflowItem_Party` (`PartyMasterId`),
  KEY `IXFK_WorkflowItem_Workflow` (`WorkflowId`),
  KEY `IXFK_WorkflowItem_XRef` (`WorkflowStateXRefId`),
  CONSTRAINT `FK_WorkflowItem_Inbox` FOREIGN KEY (`InboxId`) REFERENCES `Inbox` (`InboxId`),
  CONSTRAINT `FK_WorkflowItem_Workflow` FOREIGN KEY (`WorkflowId`) REFERENCES `Workflow` (`WorkflowId`),
  CONSTRAINT `FK_WorkflowItem_XRef` FOREIGN KEY (`WorkflowStateXRefId`) REFERENCES `XRef` (`XRefId`)
) ENGINE=InnoDB AUTO_INCREMENT=5780 DEFAULT CHARSET=latin1
CREATE TABLE `WorkflowItemData` (
  `WorkflowItemDataId` int(11) NOT NULL AUTO_INCREMENT,
  `WorkflowItemId` int(11) DEFAULT NULL,
  `MasterId` varchar(36) NOT NULL,
  `KeyName` varchar(80) NOT NULL,
  `StringValue` varchar(500) DEFAULT NULL,
  `DateValue` date DEFAULT NULL,
  `IsActive` tinyint(1) NOT NULL,
  `CreatedDateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ExpiredDateTime` datetime DEFAULT NULL,
  `ModifiedDateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`WorkflowItemDataId`),
  KEY `ChangesetData_WorkflowItem` (`WorkflowItemId`),
  CONSTRAINT `ChangesetData_WorkflowItem` FOREIGN KEY (`WorkflowItemId`) REFERENCES `WorkflowItem` (`WorkflowItemId`)
) ENGINE=InnoDB AUTO_INCREMENT=43403 DEFAULT CHARSET=latin1
CREATE TABLE `WorkflowStateChange` (
  `WorkflowStateChangeId` int(11) NOT NULL AUTO_INCREMENT,
  `MasterId` varchar(36) NOT NULL,
  `WorkflowStateFromXRefId` int(11) NOT NULL,
  `WorkflowStateToXRefId` int(11) NOT NULL,
  `InboxFromId` int(11) NOT NULL,
  `InboxToId` int(11) NOT NULL,
  `ChangedByPartyMasterId` varchar(36) NOT NULL,
  `WorkflowItemId` int(11) NOT NULL,
  `EffectiveDateTime` datetime NOT NULL,
  `ExpiredDateTime` datetime DEFAULT NULL,
  `CreatedDateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ModifiedDateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `DenialReason` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`WorkflowStateChangeId`),
  UNIQUE KEY `UXAK_MasterId` (`MasterId`),
  KEY `IXFK_WorkflowStateChange_Inbox` (`InboxFromId`),
  KEY `IXFK_WorkflowStateChange_Inbox_02` (`InboxToId`),
  KEY `IXFK_WorkflowStateChange_Party` (`ChangedByPartyMasterId`),
  KEY `IXFK_WorkflowStateChange_WorkflowItem` (`WorkflowItemId`),
  KEY `IXFK_WorkflowStateChange_XRef` (`WorkflowStateFromXRefId`),
  KEY `IXFK_WorkflowStateChange_XRef_02` (`WorkflowStateToXRefId`),
  CONSTRAINT `FK_WorkflowStateChange_Inbox` FOREIGN KEY (`InboxFromId`) REFERENCES `Inbox` (`InboxId`),
  CONSTRAINT `FK_WorkflowStateChange_Inbox_02` FOREIGN KEY (`InboxToId`) REFERENCES `Inbox` (`InboxId`),
  CONSTRAINT `FK_WorkflowStateChange_WorkflowItem` FOREIGN KEY (`WorkflowItemId`) REFERENCES `WorkflowItem` (`WorkflowItemId`),
  CONSTRAINT `FK_WorkflowStateChange_XRef` FOREIGN KEY (`WorkflowStateFromXRefId`) REFERENCES `XRef` (`XRefId`),
  CONSTRAINT `FK_WorkflowStateChange_XRef_02` FOREIGN KEY (`WorkflowStateToXRefId`) REFERENCES `XRef` (`XRefId`)
) ENGINE=InnoDB AUTO_INCREMENT=3536 DEFAULT CHARSET=latin1
CREATE TABLE `FileUpload` (
  `FileUploadId` int(11) NOT NULL AUTO_INCREMENT,
  `MasterId` varchar(36) NOT NULL,
  `FileIdentifier` varchar(36) NOT NULL,
  `FileName` varchar(256) NOT NULL,
  `WorkflowItemId` int(11) NOT NULL,
  `FileTypeXRefId` int(11) NOT NULL,
  `ExpiredDateTime` datetime DEFAULT NULL,
  `ModifiedDateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `CreatedDateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `IsActive` tinyint(1) NOT NULL,
  PRIMARY KEY (`FileUploadId`),
  KEY `FK_FileUpload_XRef` (`FileTypeXRefId`),
  KEY `FK_FileUpload_WorkflowItem` (`WorkflowItemId`),
  CONSTRAINT `FK_FileUpload_WorkflowItem` FOREIGN KEY (`WorkflowItemId`) REFERENCES `WorkflowItem` (`WorkflowItemId`),
  CONSTRAINT `FK_FileUpload_XRef` FOREIGN KEY (`FileTypeXRefId`) REFERENCES `XRef` (`XRefId`)
) ENGINE=InnoDB AUTO_INCREMENT=1303 DEFAULT CHARSET=latin1